class SendEmailJob < ApplicationJob
  queue_as :default

  def perform appointment, company, apply
    @appointment = appointment
    @company = company
    @apply = apply
    CompanyMailer.send_mailer_interviewer(@appointment, @apply, @company).deliver_later
  end
end
