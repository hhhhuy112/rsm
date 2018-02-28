class SendmailService

  def initialize email_sent, company, user_sender, apply = nil
    @email_sent = email_sent
    @company = company
    @apply = apply
    @user_sender = user_sender
  end

  def send_candidate
    from_email = @email_sent.sender_email
    to_email = @email_sent.receiver_email
    subject_email = @email_sent.title
    body_content = @email_sent.content
    SendEmailUserJob.perform_later @company, from_email,
      to_email, subject_email, body_content, @user_sender
  end

  def self.send_email_candidate from_email, to_email, subject_email, body_content, user_sender
    gmail = Gmail.connect(:xoauth2, from_email, user_sender.oauth.access_token)
    gmail.deliver do
      to to_email
      subject subject_email
      text_part do
        body body_content
      end
      html_part do
        content_type 'text/html; charset=UTF-8'
        body body_content
      end
    end
  end

  def self.send_interview  inforappointment, company, apply
    SendEmailJob.perform_later inforappointment, company, apply
  end
end
