class SendEmailUserJob < ApplicationJob
  queue_as :default

  def perform email_sent, company
    @company = company
    @email_sent = email_sent
    CompanyMailer.content_email_candidate(@email_sent, @company).deliver_later
  end
end
