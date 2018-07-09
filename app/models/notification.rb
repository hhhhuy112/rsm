class Notification < ApplicationRecord
  acts_as_paranoid

  belongs_to :user, optional: true
  belongs_to :company
  belongs_to :event, polymorphic: true

  validates :company_id, presence: true
  validates :user_read, presence: true
  validates :event, presence: true

  after_create :push_notify

  enum user_read: %i(user employer admin employee)

  serialize :readed, Array

  delegate :name, :picture, to: :user, prefix: true, allow_nil: true
  delegate :id, :job, to: :event, prefix: true, allow_nil: true

  scope :order_by_created_at, ->{order created_at: :desc}
  scope :not_user, ->user_id{where "user_id != ? OR user_id is null", user_id}
  scope :type_notify, ->type{where event_type: type}
  scope :search_user_request, ->user_id{where user_request: user_id}
  scope :search_company, ->company_ids{where company_id: company_ids}
  scope :unread_by, ->user_id do
    where("readed NOT LIKE ?", "%- #{user_id}\n%") if user_id.present?
  end

  class << self
    def create_notification user_read, event, user, company_id, user_request = nil
      Notification.transaction requires_new: true do
        user_id = user ? user.id : nil
        Notification.create user_read: user_read,
          event: event, user_id: user_id, company_id: company_id,
          user_request: user_request
      end
    end

    def search_readed user_id
      self.select { |x| x.readed.include? user_id}
    end
  end

  def readed! user_id
    self.readed ||= []
    return if self.readed.include? user_id
    self.readed << user_id
    self.save
  end

  private

  def push_notify
    ActionCable.server.broadcast "notification_channel",
      notification: render_notification(self), list_received: list_received
  end

  def render_notification notification
    ApplicationController.renderer.render partial: "notifications/notification_action_cable",
      locals: {notification: notification}
  end

  def list_received
    lists_received = User.send(self.user_read).try(:ids)
    lists_received.delete(self.user_id) if self.user_id
    lists_received
  end
end
