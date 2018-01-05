class SendEmailUserJob < ApplicationJob
  queue_as :default

<<<<<<< HEAD
<<<<<<< HEAD
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
=======
  def perform appointment, apply, template
    @appointment = appointment
    @apply = apply
    @template = template
    CompanyMailer.approved_user(@appointment, @apply, @template).deliver_later
>>>>>>> bbf4e01... fix status apply
=======
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
>>>>>>> fa774d8... fix status applies 1
  end
end
