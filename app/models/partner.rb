class Partner < ApplicationRecord
  belongs_to :company

  validates :name, presence: true
  validates :email, presence: true
  mount_uploader :picture, PartnerPictureUploader
end
