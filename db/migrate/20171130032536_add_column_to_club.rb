class AddColumnToClub < ActiveRecord::Migration[5.1]
  def change
    add_column :clubs, :position, :string, null: false
    add_column :clubs, :start_time, :date
    add_column :clubs, :end_time, :date
    add_column :clubs, :content, :text
    add_column :clubs, :current, :boolean, default: false
  end
end
