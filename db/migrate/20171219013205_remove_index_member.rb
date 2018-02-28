class RemoveIndexMember < ActiveRecord::Migration[5.1]
  def change
    remove_index :members, column: [:company_id, :user_id]
  end
end
