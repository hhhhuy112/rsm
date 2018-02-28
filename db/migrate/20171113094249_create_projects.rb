class CreateProjects < ActiveRecord::Migration[5.1]
  def change
    create_table :projects do |t|
      t.string :name
      t.text :info
      t.references :company, foreign_key: true

      t.timestamps
    end
    add_index :projects, :name
  end
end
