class User < ApplicationRecord
  attr_accessor :auto_password, :skip_cv_validation
  devise :database_authenticatable, :registerable, :confirmable, :recoverable,
    :rememberable, :trackable, :validatable, :omniauthable,
    omniauth_providers: %i(facebook google_oauth2 linkedin framgia)
  acts_as_paranoid

  belongs_to :assignment_person, class_name: User.name, foreign_key: :create_by, optional: true
  belongs_to :company, class_name: Company.name, foreign_key: :company_id
  has_many :achievements, dependent: :destroy
  has_many :clubs, dependent: :destroy
  has_many :templates, dependent: :destroy
  has_many :certificates, dependent: :destroy
  has_many :experiences, dependent: :destroy
  has_many :friends, dependent: :destroy
  has_many :microposts, dependent: :destroy
  has_many :active_follow, class_name: Relationship.name, foreign_key: "follower_id", dependent: :destroy
  has_many :passive_follow, class_name: Relationship.name, foreign_key: "followed_id", dependent: :destroy
  has_many :active_report, class_name: Report.name, foreign_key: "reporter_id", dependent: :destroy
  has_many :passive_report, class_name: Report.name, foreign_key: "reported_id", dependent: :destroy
  has_many :jobs, dependent: :destroy
  has_many :bookmark_likes, dependent: :destroy
  has_many :feedbacks, dependent: :destroy
  has_many :notifications, dependent: :destroy
  has_many :members, dependent: :destroy
  has_many :companies, through: :members
  has_many :applies, dependent: :destroy
  has_many :jobs_applied, class_name: Job.name, through: :applies, source: :job, dependent: :destroy
  has_many :inforappointments
  has_many :offers, dependent: :destroy
  has_one :oauth, dependent: :destroy
  has_many :apply_statuses, through: :applies
  has_many :notes, dependent: :destroy
  has_many :email_sents, dependent: :destroy
  belongs_to :assignment_person, class_name: User.name, foreign_key: :create_by, optional: true

  validates :name, presence: true
  validates :email, uniqueness: { scope: :company_id,
    message: I18n.t("users.form.empty") }
  validates :code, uniqueness: {scope: :company_id}, presence: true
  validates :cv, presence: true, allow_nil: true, unless: :skip_cv_validation
  validates :phone, length: {maximum: Settings.phone_max_length}, allow_nil: true
  validate :birthday_cannot_be_in_the_future

  before_validation(on: :create) do
    code_id = User.with_deleted.last&.id
    code_id = code_id ? (code_id + Settings.code.default_val) : Settings.code.default_val
    self.code = "#{Settings.code.text}#{Faker::Number.number(Settings.code.element)}#{code_id}"
  end

  enum role: {user: 0, employer: 1, admin:2, employee: 3}
  enum sex: {female: 0, male: 1}

  delegate :token, to: :oauth, prefix: true, allow_nil: true
  delegate :subdomain, to: :company, prefix: true

  scope :search_name_or_mail, ->(content){where("name LIKE ? or email LIKE ?", "%#{content}%", "%#{content}%")}
  scope :not_member, ->{where("id NOT IN (SELECT user_id FROM members where end_time IS NUll)")}
  scope :not_role, ->(role){where.not role: role}
  scope :by_roles, ->roles{where role: roles}
  scope :of_company, ->(company){where company_id: company}
  scope :get_by_id, ->ids{where id: ids}
  scope :newest, ->{order created_at: :desc}
  scope :get_by_code, ->code{where "code LIKE :code", code: "%#{code}%"}

  mount_uploader :picture, PictureUploader
  mount_uploader :cv, CvUploader

  def self_attr_after_save auto_password
    self.auto_password = auto_password
  end

  def is_user? user
    user == self
  end

  def is_employer_of? company_id
    return false if company.blank?
    self.is_member_of?(company_id) && self.employer?
  end

  def is_member_of? company_id
    self.company.id = company_id
  end

  def is_applied? job_id
    self.applies.pluck(:job_id).include? job_id
  end

  def birthday_cannot_be_in_the_future
    if birthday.present? && birthday > Date.today
      errors.add :birthday, I18n.t("users.form.birthday.validate")
    end
  end

  class << self
    def is_user_candidate_exist? email
      applies = Apply.get_by_email email
      return true if applies.present?
      user = User.find_by email: email
      return false if user.blank?
      applies_user = Apply.get_by_user user.id
      return applies_user.present?
    end

    def auto_create_user company_id, information, cv, user_id
      password = Devise.friendly_token.first(Settings.password.length)
      user = User.new email: information[:email], name: information[:name],
        password: password, company_id: company_id, phone: information[:phone],
        address: information[:address], cv: cv, create_by: user_id
      user.self_attr_after_save password
      user.save!
      user
    end
  end
end
