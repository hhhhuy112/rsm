class AddDeletedAtToClubs < ActiveRecord::Migration[5.1]
  def change
    add_column :clubs, :deleted_at, :datetime
  end
end
