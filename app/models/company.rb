class Company < ApplicationRecord
  has_many :appointments, dependent: :destroy
  has_many :projects, dependent: :destroy
  has_many :jobs, dependent: :destroy
  has_many :questions, dependent: :destroy
  has_many :applies, through: :jobs, dependent: :destroy
  has_many :members, dependent: :destroy
  has_many :users, through: :members, dependent: :destroy
  has_many :passive_report, class_name: Report.name, as: :reported, dependent: :destroy
  has_many :passive_follow, class_name: Relationship.name, as: :followed, dependent: :destroy
  has_many :company_activities, dependent: :destroy
  has_one :company_setting, dependent: :destroy
  has_many :partners, dependent: :destroy
  has_many :branches
  has_many :categories
  has_many :company_steps
  has_many :apply_statuses, through: :applies
  has_many :steps, through: :company_steps
  has_many :status_steps, through: :steps
  has_many :categories

  delegate :enable_send_mail, to: :company_setting, allow_nil: true, prefix: true

  accepts_nested_attributes_for :company_activities, allow_destroy: true
  accepts_nested_attributes_for :partners, allow_destroy: true
  accepts_nested_attributes_for :branches, allow_destroy: true
  accepts_nested_attributes_for :categories, allow_destroy: true

  mount_uploader :banner, ImageUploader
  mount_uploader :logo, LogoUploader

  validates :name, presence: true
  validates :majors, presence: true
  validates :contact_person, presence: true
  VALID_PHONE_REGEX = /\A(?:\+?\d{1,3}\s*-?)?\(?(?:\d{3})?\)?[- ]?\d{3}[- ]?\d{4}\z/i
  validates :phone, presence: true, format: {with: VALID_PHONE_REGEX}, uniqueness: {case_sensitive: false}
end
