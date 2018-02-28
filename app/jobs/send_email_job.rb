class SendEmailJob < ApplicationJob
  queue_as :default

  def perform inforappointment, company, apply
    @inforappointment = inforappointment
    @company = company
    @apply = apply
    CompanyMailer.send_mailer_interviewer(@inforappointment, @apply, @company).deliver_later
  end
end
