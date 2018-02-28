class Achievement < ApplicationRecord
  acts_as_paranoid

  belongs_to :user
  validates :name, presence: true
  validates :majors, presence: true
  validates :organization, presence: true
  validates :received_time, presence: true
end
