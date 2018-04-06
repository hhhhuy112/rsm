class SendmailService

  def initialize email_sents, company, apply = nil
    @email_sents = email_sents
    @company = company
    @apply = apply
  end

  def send_candidate user = nil
    candidate_title = @email_sents.title
    candidate_email = @email_sents.receiver_email
    if user
      email_sender = user.email
      access_token = user.oauth&.token
    else
      email_sender = @email_sents.user_email
      access_token = @email_sents.user.oauth_token
    end
    SendEmailUserJob.perform_later @email_sents.content, @company, candidate_title,
      candidate_email, email_sender, access_token
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

    def send_mail_by_gmail content, company, title, email, email_sender, access_token
      gmail = Gmail.connect(:xoauth2, email_sender, access_token)
      mail = gmail.compose do
        to email
        subject title
        html_part do
          content_type "text/html; charset=UTF-8"
          body ""
        end
        add_file "#{Rails.root.join("app/assets/images/logo.png")}"
      end
      logo_url = mail.body.parts.second.url
      mail.html_part.body = SendmailService.get_template_mailer content, logo_url
      mail.deliver!
    end
  end
end
