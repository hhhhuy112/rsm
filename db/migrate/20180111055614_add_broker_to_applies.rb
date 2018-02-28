class AddBrokerToApplies < ActiveRecord::Migration[5.1]
  def change
    add_column :applies, :broker, :string
  end
end
