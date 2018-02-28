class Certificate < ApplicationRecord
  acts_as_paranoid

  belongs_to :user
  validates :name, presence: true, length: {maximum: Settings.certificate.maximum}
  validates :majors, presence: true, length: {maximum: Settings.certificate.maximum}
  validates :organization, presence: true, length: {maximum: Settings.certificate.maximum}
  validates :classification, presence: true, length: {maximum: Settings.certificate.maximum}
  validates :received_time, presence: true
end
