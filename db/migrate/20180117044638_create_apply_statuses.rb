class CreateApplyStatuses < ActiveRecord::Migration[5.1]
  def change
    create_table :apply_statuses do |t|
      t.references :apply, foreign_key: true
      t.references :status_step, foreign_key: true
      t.text :content_email
      t.integer :is_current
      t.timestamps
    end
  end
end
