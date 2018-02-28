class AddDeletedAtToExperiences < ActiveRecord::Migration[5.1]
  def change
    add_column :experiences, :deleted_at, :datetime
  end
end
