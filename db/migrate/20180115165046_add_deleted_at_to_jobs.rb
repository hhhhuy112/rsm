class AddDeletedAtToJobs < ActiveRecord::Migration[5.1]
  def change
    add_column :jobs, :deleted_at, :datetime
  end
end
