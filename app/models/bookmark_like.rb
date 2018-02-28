class BookmarkLike < ApplicationRecord
  acts_as_paranoid

  belongs_to :user
  belongs_to :job
  has_one :company, through: :job

  enum bookmark: %i(bookmark like)
  scope :is_bookmark, ->{where(bookmark: BookmarkLike.bookmarks.keys[Settings.bookmark.bookmarked])}
end
