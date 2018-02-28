class CreateCompanySteps < ActiveRecord::Migration[5.1]
  def change
    create_table :company_steps do |t|
      t.references :step, foreign_key: true
      t.references :company, foreign_key: true
      t.integer :priority
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
