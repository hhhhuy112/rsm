class AddInfoToCompanies < ActiveRecord::Migration[5.1]
  def change
    add_column :companies, :contact_person, :string
    add_column :companies, :company_info, :text
    add_column :companies, :logo , :string
    add_column :companies, :banner, :string
    add_column :companies, :url_company, :string
  end
end
