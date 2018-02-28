class AddReadToNotifications < ActiveRecord::Migration[5.1]
  def change
    add_column :notifications, :readed, :text
    add_column :notifications, :user_request, :integer
    add_column :notifications, :company_id, :integer
  end
end
