class AddInformationToApplies < ActiveRecord::Migration[5.1]
  def change
    add_column :applies, :information, :text
  end
end
