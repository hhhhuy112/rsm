class AddTitleToTemplates < ActiveRecord::Migration[5.1]
  def change
    add_column :templates, :title, :string
  end
end
