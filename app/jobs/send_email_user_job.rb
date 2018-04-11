class SendEmailUserJob < ApplicationJob
  queue_as :default

  def perform params
    SendmailService.send_mail_by_gmail params
  end
end
