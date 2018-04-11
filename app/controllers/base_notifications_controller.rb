class BaseNotificationsController < ApplicationController

  protected

  def readed_notification
    return unless @notification && user_signed_in?
    users_read_all = @notification.readed
    if users_read_all.blank?
      @notification.update_attributes readed: [current_user.id]
    elsif !users_read_all.include?(current_user.id)
      users_read_all << current_user.id
      @notification.update_attributes readed: users_read_all
    end
  end

  def load_notify
    @notification = Notification.find_by id: params[:notify_id]
    @notification ||= Notification.type_notify(Settings.apply.name)
      .find_by event_id: params[:id], user_read: :employer
  end

  def load_notifications
    return unless user_signed_in?
    if current_user.members.find_by position: :employer
      company_manager = Member.search_relation(Member.roles[:employer], current_user.id)
        .pluck :company_id
      @notifications = Notification.includes(:user).includes(:event)
        .employer.not_user(current_user.id).search_company(company_manager).order_by_created_at
      classify_notify company_manager
    else
      @notifications = Notification.includes(:user).includes(:event)
        .user.not_user(current_user.id).search_user_request(current_user.id).order_by_created_at
      classify_notify
    end
  end

  def load_email_sents
    return if request.xhr? && not_send_mail_controller?
    @email_sents = current_user.email_sents.newest.includes :apply, :job
  end

  private

  def classify_notify company_manager = nil
    return unless @notifications
    if company_manager
      @notify_readed = @notifications.search_readed current_user.id
    else
      @notify_readed = @notifications.search_readed current_user.id
    end
    @notify_unread = @notifications - @notify_readed
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
