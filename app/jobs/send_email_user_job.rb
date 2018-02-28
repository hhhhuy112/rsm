class SendEmailUserJob < ApplicationJob
  queue_as :default

  def perform company, from_email, to_email, subject_email, body_content, user_sender
    @user_sender = user_sender
    @from_email = from_email
    @to_email = to_email
    @subject_email = subject_email
    @body_content = body_content
    SendmailService.send_email_candidate @from_email, @to_email, @subject_email, @body_content, @user_sender
  end

  def send_mailer_candidate

  end
end
