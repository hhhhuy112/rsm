class CreateExperiences < ActiveRecord::Migration[5.1]
  def change
    create_table :experiences do |t|
      t.string :name
      t.string :company
      t.date :start_time
      t.date :end_time
      t.text :project_detail
      t.references :user, foreign_key: true

      t.timestamps
    end
    add_index :experiences, :name
  end
end
