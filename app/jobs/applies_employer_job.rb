class AppliesEmployerJob < ApplicationJob
  queue_as :default

  def perform apply
    @apply = apply
    CompanyMailer.welcome_email(@apply).deliver_later
  end
end
