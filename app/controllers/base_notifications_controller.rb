class BaseNotificationsController < ApplicationController

  protected

  def readed_notification
    return unless @notification && user_signed_in?
    @notification.readed! current_user.id
  end

  def load_notify
    @notification = Notification.find_by id: params[:notify_id]
    @notification ||= Notification.type_notify(Settings.apply.name)
      .find_by event_id: params[:id], user_read: :employer
  end

  def load_notifications
    return unless user_signed_in?
    @notifications = if current_user.employer?
      current_user.company.notifications.includes(:user, :event)
        .employer.not_user(current_user.id).order_by_created_at
    else
      current_user.company.notifications.includes(:user, :event)
        .user.not_user(current_user.id).search_user_request(current_user.id).order_by_created_at
    end
    load_unread_notifications_by_current_user
  end

  def load_email_sents
    return if request.xhr? && not_send_mail_controller?
    @email_sents = current_user.email_sents.newest.includes :apply, :job
  end

  private

  def load_unread_notifications_by_current_user
    return unless @notifications
    @notify_unread = @notifications.unread_by current_user.id
  end

  def load_search_form
    applies_status = @company.apply_statuses.current
    @q = applies_status.search params[:q]
  end

  def not_send_mail_controller?
    controller_name_segments = params[:controller].split("/")
    controller_name_segments.pop != Settings.send_emails
  end
end
