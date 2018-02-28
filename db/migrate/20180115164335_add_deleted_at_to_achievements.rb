class AddDeletedAtToAchievements < ActiveRecord::Migration[5.1]
  def change
    add_column :achievements, :deleted_at, :datetime
  end
end
