class CreateAchievements < ActiveRecord::Migration[5.1]
  def change
    create_table :achievements do |t|
      t.string :name
      t.string :majors
      t.string :organization
      t.date :received_time
      t.references :user, foreign_key: true

      t.timestamps
    end
    add_index :achievements, :name
  end
end
