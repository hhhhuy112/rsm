class CreateTemplates < ActiveRecord::Migration[5.1]
  def change
    create_table :templates do |t|
      t.text :template_body
      t.string :name
      t.references :user, foreign_key: true
      t.integer :type_of, default: 1
      t.timestamps
    end
  end
end
