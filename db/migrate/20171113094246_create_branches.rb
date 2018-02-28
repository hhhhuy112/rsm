class CreateBranches < ActiveRecord::Migration[5.1]
  def change
    create_table :branches do |t|
      t.integer :is_head_office, null: false, default: 0
      t.string :name, null: false
      t.string :phone
      t.string :street, null: false
      t.string :ward
      t.string :district
      t.string :province, null: false
      t.string :country, null: false
      t.integer :status, null: false, default: 0
      t.references :company, foreign_key: true

      t.timestamps
    end
  end
end
