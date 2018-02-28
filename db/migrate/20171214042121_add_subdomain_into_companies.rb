class AddSubdomainIntoCompanies < ActiveRecord::Migration[5.1]
  def change
    add_column :companies, :subdomain, :string, null: false, unique: true
  end
end
