class CreateOauths < ActiveRecord::Migration[5.1]
  def change
    create_table :oauths do |t|
      t.string :access_token
      t.string :refresh_token
      t.references :user, foreign_key: true
      t.integer :expires_at

      t.timestamps
    end
  end
end
