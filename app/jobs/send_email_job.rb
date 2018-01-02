class SendEmailJob < ApplicationJob
  queue_as :default

  def perform user,template
    @user = user
    @template = template
    CompanyMailer.send_member(@user, @template).deliver_later
  end
end
