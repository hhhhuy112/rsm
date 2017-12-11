class BookmarkLike < ApplicationRecord
  belongs_to :user
  belongs_to :job
  has_one :company, through: :job

  enum bookmark: [ :bookmark, :like ]
  scope :is_bookmark, ->{where(bookmark: BookmarkLike.bookmarks.keys[Settings.bookmark.bookmarked])}
end
