class AddActivationToInforappointments < ActiveRecord::Migration[5.1]
  def change
    add_column :inforappointments, :activation_digest, :string
    add_column :inforappointments, :activated, :integer, default: 0
  end
end
