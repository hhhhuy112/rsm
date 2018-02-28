class CreateEmailSents < ActiveRecord::Migration[5.1]
  def change
    create_table :email_sents do |t|
      t.string :title
      t.text :content
      t.string :sender_email
      t.references :user, foreign_key: true
      t.string :receiver_email
      t.string :type
      t.integer :type_id

      t.timestamps
    end
  end
end
