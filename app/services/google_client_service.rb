class GoogleClientService
  def initialize user
    @gmail = connect_gmail user.email, user.oauth_token
  end

  def connect_gmail email, access_token
    Gmail.connect :xoauth2, email, access_token
  rescue
    push_notify_mail params[:email_sent], I18n.t("employers.email_sents.email_sent.fail")
  end

  def get_emails
    @gmail.inbox.emails(gm: "'filename:doc OR filename:docx OR filename:pdf'")
  end

  def load_email gmail_uid
    @gmail.inbox.find(uid: gmail_uid)
  end

  def send_mail params
    mail = @gmail.compose do
      to params[:email_sent].receiver_email
      subject params[:email_sent].title
      html_part do
        content_type "text/html; charset=UTF-8"
        body ""
      end
      add_file "#{Rails.root.join("app/assets/images/logo.png")}"
    end
    logo_url = mail.body.parts.second.url
    mail.html_part.body = GoogleClient.get_template_mailer params[:email_sent].content, logo_url
    mail.deliver!
    params[:email_sent].update_column :status, :success
    push_notify_mail params[:email_sent], I18n.t("employers.email_sents.email_sent.success"), Settings.success
  rescue
    push_notify_mail params[:email_sent], I18n.t("employers.email_sents.email_sent.fail")
  end

  def get_template_mailer content, logo_url
    ApplicationController.new.render_to_string template: "company_mailer/send_mailer_candidate",
    layout: "layouts/gmail", assigns: {content: content, logo_url: logo_url}
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
