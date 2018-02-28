class AddDeletedAtToBookmarkLikes < ActiveRecord::Migration[5.1]
  def change
    add_column :bookmark_likes, :deleted_at, :datetime
  end
end
