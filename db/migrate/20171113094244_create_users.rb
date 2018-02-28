class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name
      t.date :birthday
      t.string :email
      t.string :phone
      t.text :address
      t.integer :sex
      t.integer :role, default: 1
      t.references :company, foreign_key: true

      t.timestamps
    end
    add_index :users, :name
  end
end
