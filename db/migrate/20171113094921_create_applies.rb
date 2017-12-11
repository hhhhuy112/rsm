class CreateApplies < ActiveRecord::Migration[5.1]
  def change
    create_table :applies do |t|
      t.integer :status, default: 0
      t.references :user, foreign_key: true
      t.references :job, foreign_key: true
      t.index [:user_id, :job_id], unique: true
      t.timestamps
    end
  end
end
