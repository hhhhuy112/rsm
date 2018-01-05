class SendEmailUserJob < ApplicationJob
  queue_as :default

  def perform appointment, apply, template
    @appointment = appointment
    @apply = apply
    @template = template
    CompanyMailer.approved_user(@appointment, @apply, @template).deliver_later
  end
end
