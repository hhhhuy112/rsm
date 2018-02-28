class CreateCompanySettings < ActiveRecord::Migration[5.1]
  def change
    create_table :company_settings do |t|
      t.references :company, foreign_key: true
      t.text :enable_send_mail
      t.timestamps
    end
  end
end
