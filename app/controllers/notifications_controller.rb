class NotificationsController < BaseNotificationsController
  before_action :authenticate_user!
  before_action :load_notifications, only: %i(index update)

  def index
    respond_to do |format|
      @notifications = @notifications.page(params[:page]).per Settings.applies_max
      format.js
    end
  end

  def update
    return unless @notify_unread
    @notify_unread.find_each do |notify|
      notify.readed!
    end
    load_notifications
    respond_to do |format|
      format.js
    end
  end
end
