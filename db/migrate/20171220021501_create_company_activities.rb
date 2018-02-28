class CreateCompanyActivities < ActiveRecord::Migration[5.1]
  def change
    create_table :company_activities do |t|
      t.string :title
      t.string :picture
      t.text :description
      t.references :company, foreign_key: true

      t.timestamps
    end
  end
end
