class AddStatusToJobs < ActiveRecord::Migration[5.1]
  def change
    add_column :jobs, :status, :integer, default: 0
  end
end
