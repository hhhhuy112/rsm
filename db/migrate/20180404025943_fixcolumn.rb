class Fixcolumn < ActiveRecord::Migration[5.1]
  def change
    change_column :jobs, :skill, :text
  end
end
