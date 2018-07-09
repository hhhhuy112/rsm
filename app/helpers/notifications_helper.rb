module NotificationsHelper
  def check_notify notification
    if notification.event.kind_of? Job
      @notice = {link: job_path(notification.event, notify_id: notification.id),
        content: t("notifications.notification.content_create_job"),
        name: notification.event.name}
    elsif notification.event.kind_of? Apply
      @notice = if notification.user?
        {content: t("notifications.notification.content_update_apply")}
      else
        {content: t("notifications.notification.content_create_apply")}
      end
      @notice[:link] = employers_job_apply_path notification.event_job,
        id: notification.event_id, notify_id: notification.id
      @notice[:name] = notification.event_job.name
    end
  end

  def show_image notification
    return "user_avatar_default.png" if notification.user_id.blank?
    notification.user_picture.url || "user_avatar_default.png"
  end

  def notify_counter notify
    if notify.present?
      notify.size
    else
      Settings.not_notify
    end
  end

  def readed_unread_notify notify
    return :unread unless user_signed_in?
    if notify.readed.include? current_user.id
      :readed
    else
      :unread
    end
  end
end
