class CreateInforappointments < ActiveRecord::Migration[5.1]
  def change
    create_table :inforappointments do |t|
      t.references :user, foreign_key: true
      t.references :appointment, foreign_key: true
      t.timestamps
    end
  end
end
