class CreateCompanies < ActiveRecord::Migration[5.1]
  def change
    create_table :companies do |t|
      t.string :name
      t.text :address
      t.string :phone
      t.string :majors

      t.timestamps
    end
    add_index :companies, :name
  end
end
