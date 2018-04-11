class AddStausToEmailSent < ActiveRecord::Migration[5.1]
  def change
    add_column :email_sents, :status, :integer, default: 0
  end
end
