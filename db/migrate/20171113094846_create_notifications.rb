class CreateNotifications < ActiveRecord::Migration[5.1]
  def change
    create_table :notifications do |t|
      t.text :content
      t.boolean :status
      t.integer :type
      t.integer :url_id
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
