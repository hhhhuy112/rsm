class CreateCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :categories do |t|
      t.string :name, null: false
      t.text :description
      t.integer :status, null: false, default: 0
      t.references :company, foreign_key: true

      t.timestamps
    end
  end
end
