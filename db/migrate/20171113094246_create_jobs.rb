class CreateJobs < ActiveRecord::Migration[5.1]
  def change
    create_table :jobs do |t|
      t.text :content
      t.string :name
      t.string :level
      t.string :language
      t.string :skill
      t.string :position
      t.text :description
      t.references :user, foreign_key: true
      t.references :company, foreign_key: true

      t.timestamps
    end
    add_index :jobs, :name
  end
end
