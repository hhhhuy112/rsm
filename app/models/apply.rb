class Apply < ApplicationRecord
  attr_accessor :user, :key_apply

  belongs_to :job
  belongs_to :user, optional: true
  has_many :answers, dependent: :destroy
  has_one :company, through: :job
  has_many :inforappointments, through: :appointments
  has_many :apply_statuses, dependent: :destroy
  has_many :appointments, through: :apply_statuses, dependent: :destroy
  has_many :status_steps, through: :apply_statuses, dependent: :destroy
  has_many :steps, through: :status_steps, dependent: :destroy
  has_many :offers, through: :apply_statuses

  serialize :information, Hash

  after_create :create_activity_notify

  validates :cv, presence: true
  validates :job_id, presence: true
  validates :information, presence: true
  enum status: {unlock_apply: 0, lock_apply: 1, cancel_apply: 2}

  accepts_nested_attributes_for :apply_statuses, allow_destroy: true , update_only: true
  accepts_nested_attributes_for :answers, allow_destroy: true

  scope :newest_apply, ->{order :created_at}
  scope :sort_apply, ->{order(created_at: :desc).limit Settings.job.limit}
  scope :lastest_apply, ->{order created_at: :desc}

  mount_uploader :cv, CvUploader

  delegate :name, to: :job, prefix: true, allow_nil: true
  delegate :name, to: :step, prefix: true, allow_nil: true
  delegate :phone, :email, :name, to: :user, prefix: true, allow_nil: true

  include PublicActivity::Model

  validates_hash_keys :information do
    validates :name, presence: true
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, format: {with: VALID_EMAIL_REGEX}
    validates :phone, presence: true
    validates :introducing, presence: true
  end

  def of_user? user
    false if user.blank?
    user.id == self.user_id
  end

  def save_activity key, user = nil, params = nil
    self.transaction requires_new: true do
      if params
        self.create_activity key, owner: user, parameters: {status: params}
      else
        self.create_activity key, owner: user
      end
    end
  rescue
  end

  def self_attr_after_create user, key_apply
    self.user = user
    self.key_apply = key_apply
  end

  private

  def create_activity_notify
    self.save_activity :create, user
    Notification.create_notification key_apply, self, user, self.job.company_id if user || key_apply
    AppliesUserJob.perform_later self
    AppliesEmployerJob.perform_later self
  rescue ActiveRecord::RecordInvalid
  end
end
