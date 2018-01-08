class SendEmailUserJob < ApplicationJob
  queue_as :default

  def perform status, appointment, apply, template, company
    @appointment = appointment
    @apply = apply
    @template = template
    @company = company
    send_email_by_status
  end

  private

  def send_email_by_status
    case
    when @apply.review_not_selected?
      CompanyMailer.review_not_selected @apply, @company
    when @apply.interview_scheduled?
      CompanyMailer.interview_scheduled_candidate(@appointment,
      @apply, @template, @company).deliver_later
    else
    end
  end
end
