class SendEmailUserJob < ApplicationJob
  queue_as :default

  def perform user, template
    @user = user
    @template = template
    CompanyMailer.approved_user(@user, @template).deliver_later
  end
end
