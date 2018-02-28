class CreateCertificates < ActiveRecord::Migration[5.1]
  def change
    create_table :certificates do |t|
      t.string :name
      t.string :majors
      t.string :organization
      t.string :classification
      t.date :received_time
      t.references :user, foreign_key: true

      t.timestamps
    end
    add_index :certificates, :name
  end
end
