class AppliesUserJob < ApplicationJob
  queue_as :default

  def perform apply
    @apply = apply
    CompanyMailer.user_mail(@apply).deliver_later
  end
end
