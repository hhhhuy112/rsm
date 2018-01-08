class SendEmailJob < ApplicationJob
  queue_as :default

  def perform inforappointment, template, company
    @inforappointment = inforappointment
    @template = template
    @company = company
    CompanyMailer.interview_scheduled_interviewer(@inforappointment,
      @template, @company).deliver_later
  end
end
