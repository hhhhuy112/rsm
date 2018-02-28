class AddCvToApplies < ActiveRecord::Migration[5.1]
  def change
    add_column :applies, :cv, :text
  end
end
