class AddEventToNotifications < ActiveRecord::Migration[5.1]
  def change
    add_belongs_to :notifications, :event, polymorphic: true, index: true
    rename_column :notifications, :type, :user_read
    change_column_default :notifications, :status, 0
  end
end
