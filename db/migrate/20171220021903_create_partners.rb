class CreatePartners < ActiveRecord::Migration[5.1]
  def change
    create_table :partners do |t|
      t.string :name
      t.string :email
      t.string :picture
      t.text :description
      t.references :company, foreign_key: true

      t.timestamps
    end
  end
end
