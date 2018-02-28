class CreateMembers < ActiveRecord::Migration[5.1]
  def change
    create_table :members do |t|
      t.string :position
      t.date :start_time
      t.date :end_time
      t.integer :role, default: 0
      t.references :company, foreign_key: true
      t.references :user, foreign_key: true
      t.index [:company_id, :user_id], unique: true

      t.timestamps
    end
  end
end
