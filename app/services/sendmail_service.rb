class SendmailService

  def initialize email_sents, company, apply = nil
    @email_sents = email_sents
    @company = company
    @apply = apply
  end

  def send_candidate user = nil
    if user
      email_sender = user.email
      access_token = user.oauth&.token
    else
      email_sender = @email_sents.user_email
      access_token = @email_sents.user.oauth_token
    end
    params = {email_sent: @email_sents, email_sender: email_sender, access_token: access_token}
    SendEmailUserJob.set(wait: Settings.wait_time.seconds).perform_later params
  end

  class << self
    def send_interview appointment, company, apply
      SendEmailJob.perform_later appointment, company, apply
    end

    def send_interviewer_all appointment, company, apply
      SendEmailJob.perform_later inforappointment, company, apply
    end

    def get_template_mailer content, logo_url
      ApplicationController.new.render_to_string template: "company_mailer/send_mailer_candidate",
        layout: "layouts/gmail", assigns: {content: content, logo_url: logo_url}
    end

    def send_mail_by_gmail params
      gmail = Gmail.connect :xoauth2, params[:email_sender], params[:access_token]
      mail = gmail.compose do
        to params[:email_sent].receiver_email
        subject params[:email_sent].title
        html_part do
          content_type "text/html; charset=UTF-8"
          body ""
        end
        add_file "#{Rails.root.join("app/assets/images/logo.png")}"
      end
      logo_url = mail.body.parts.second.url
      mail.html_part.body = SendmailService.get_template_mailer params[:email_sent].content, logo_url
      mail.deliver!
      params[:email_sent].update_column :status, :success
      push_notify_mail params[:email_sent], I18n.t("employers.email_sents.email_sent.success"), Settings.success
    rescue
      push_notify_mail params[:email_sent], I18n.t("employers.email_sents.email_sent.fail")
    end

    def push_notify_mail email_sent, message, status = nil
      ActionCable.server.broadcast "notify_send_mail_channel", notify_mail: render_notify_mail(email_sent),
        status: status, user: email_sent.user_id, message: message, id: email_sent.id
    end

    def render_notify_mail email_sent
      ApplicationController.renderer.render partial: "employers/email_sents/mail_sent",
        locals: {email_sent: email_sent}
    end
  end
end
