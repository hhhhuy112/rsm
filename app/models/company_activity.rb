class CompanyActivity < ApplicationRecord
  belongs_to :company

  validates :title, presence: true
  mount_uploader :picture, ActivityPictureUploader
end
