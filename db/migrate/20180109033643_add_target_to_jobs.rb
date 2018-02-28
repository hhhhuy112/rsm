class AddTargetToJobs < ActiveRecord::Migration[5.1]
  def change
    add_column :jobs, :target, :integer
  end
end
