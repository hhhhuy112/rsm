class AddApplyStatusToAppointment < ActiveRecord::Migration[5.1]
  def change
    add_reference :appointments, :apply_status, foreign_key: true
  end
end
