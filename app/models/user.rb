class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable
  has_many :achievements, dependent: :destroy
  has_many :clubs, dependent: :destroy
  has_many :templates, dependent: :destroy
  has_many :certificates, dependent: :destroy
  has_many :experiences, dependent: :destroy
  has_many :friends, dependent: :destroy
  has_many :microposts, dependent: :destroy
  has_many :active_follow, class_name: Relationship.name, foreign_key: "follower_id", dependent: :destroy
  has_many :passive_follow, class_name: Relationship.name, as: :followed, dependent: :destroy
  has_many :active_report, class_name: Report.name, foreign_key: "reporter_id", dependent: :destroy
  has_many :passive_report, class_name: Report.name, as: :reported, dependent: :destroy
  has_many :jobs, dependent: :destroy
  has_many :bookmark_likes, dependent: :destroy
  has_many :feedbacks, dependent: :destroy
  has_many :notifications, dependent: :destroy
  has_many :members, dependent: :destroy
  has_many :companies, through: :members
  has_many :applies, dependent: :destroy
  has_many :inforappointments
  validates :name, presence: true

  enum role: %i(user employer admin)
  enum sex: {female: 0, male: 1}
  scope :search_name_or_mail, ->(content){where("name LIKE ? or email LIKE ?", "%#{content}%", "%#{content}%")}
  scope :not_member, ->{where("id NOT IN (SELECT user_id FROM members where end_time IS NUll)")}
  scope :not_role, ->(role){where.not role: role}

  mount_uploader :picture, PictureUploader
  mount_uploader :cv, CvUploader

  def is_user? user
    user == self
  end

  def is_employer_of? company_id
    return false if self.companies.last.blank?
    self.companies.last.id == company_id &&
      self.members.last.end_time.nil? && self.members.last.employer?
  end

  def is_employer?
    return false if self.companies.last.blank?
    self.members.last.end_time.nil? && self.members.last.employer?
  end
end
