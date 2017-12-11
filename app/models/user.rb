class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable
  has_many :achievements, dependent: :destroy
  has_many :clubs, dependent: :destroy
  has_many :certificates, dependent: :destroy
  has_many :experiences, dependent: :destroy
  has_many :friends, dependent: :destroy
  has_many :microposts, dependent: :destroy
  has_many :active_follow, class_name: Relationship.name, foreign_key: "follower_id", dependent: :destroy
  has_many :passive_follow, class_name: Relationship.name, as: :followed
  has_many :active_report, class_name: Report.name, foreign_key: "reporter_id", dependent: :destroy
  has_many :passive_report, class_name: Report.name, as: :reported
  has_many :jobs, dependent: :destroy
  has_many :bookmark_likes, dependent: :destroy
  has_many :feedbacks, dependent: :destroy
  has_many :applies, dependent: :destroy
  has_many :appointments, dependent: :destroy
  has_many :notifications, dependent: :destroy
  has_many :members, dependent: :destroy
  has_many :companies, through: :members
  validates :name, presence: true

  enum role: %i(user employer admin)
  enum sex: {female: 0, male: 1}
  mount_uploader :picture, PictureUploader

  def is_user? user
    user == self
  end

  def is_employer? company
    self.companies.last == company && self.members.last.present? && self.members.last.end_time.nil?
  end
end
