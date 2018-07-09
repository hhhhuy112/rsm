class CreateSkills < ActiveRecord::Migration[5.2]
  def change
    create_table :skills do |t|
      t.string :name
      t.references :company, foreign_key: true
      t.integer :type_skill, default: 0
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
