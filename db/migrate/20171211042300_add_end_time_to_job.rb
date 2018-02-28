class AddEndTimeToJob < ActiveRecord::Migration[5.1]
  def change
    add_column :jobs, :end_time, :date
  end
end
