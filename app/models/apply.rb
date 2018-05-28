class Apply < ApplicationRecord
  acts_as_paranoid
  attr_accessor :current_user, :key_apply

  belongs_to :job, optional: true
  belongs_to :user, optional: true
  has_many :answers, dependent: :destroy
  has_one :company, through: :job
  has_many :apply_statuses, dependent: :destroy
  has_many :appointments, through: :apply_statuses, dependent: :destroy
  has_many :inforappointments, through: :appointments
  has_many :status_steps, through: :apply_statuses, dependent: :destroy
  has_many :steps, through: :status_steps, dependent: :destroy
  has_many :offers, through: :apply_statuses
  has_many :notes, dependent: :destroy

  serialize :information, Hash

  after_create :create_user, :create_activity_notify

  validates :cv, presence: true
  validates :information, presence: true
  enum status: {unlock_apply: 0, lock_apply: 1, cancel_apply: 2}

  accepts_nested_attributes_for :apply_statuses, allow_destroy: true , update_only: true
  accepts_nested_attributes_for :answers, allow_destroy: true

  scope :newest_apply, ->{order :created_at}
  scope :sort_apply, ->{order(created_at: :desc).limit Settings.job.limit}
  scope :lastest_apply, ->{order created_at: :desc}
  scope :get_by_user, ->user_id{where user_id: user_id}
  scope :get_by_job, ->job_id{where job_id: job_id}
  scope :get_have_job, ->{where.not job_id: nil}
  scope :get_have_user, ->{where.not user_id: nil}
  scope :get_by_email, ->email{where "information LIKE ?", "%\nemail: #{email}\n%"}
  scope :email_of_information, -> email do
    where "SUBSTRING_INDEX(SUBSTRING_INDEX(information, ':', #{Settings.apply.information.email_end}), ':', #{Settings.apply.information.email_start}) LIKE ?", "%#{email}%"
  end
  scope :of_cadidate, -> user_ids{where user_id: user_ids}

  mount_uploader :cv, CvUploader

  delegate :name, to: :job, prefix: true, allow_nil: true
  delegate :name, to: :step, prefix: true, allow_nil: true
  delegate :phone, :email, :name, :id, :code, to: :user, prefix: true, allow_nil: true
  delegate :id, to: :company, prefix: true, allow_nil: true

  include PublicActivity::Model

  validates_hash_keys :information do
    validates :name, presence: true, length: {maximum: Settings.apply.model.name_max_length,
      minimum: Settings.apply.model.name_min_length}
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, format: {with: VALID_EMAIL_REGEX}
    validates :phone, presence: true, length: {maximum: Settings.apply.model.phone_max_length,
      minimum: Settings.apply.model.phone_min_length}, numericality: true
  end

  def of_user? user
    false if user.blank?
    user.id == self.user_id
  end

  def save_activity key, user = nil, params = nil
    user = user ? user : self.user
    self.transaction requires_new: true do
      if params
        self.create_activity key, owner: user, parameters: {status: params}, recipient: self
      else
        self.create_activity key, owner: user, recipient: self
      end
    end
  rescue
  end

  def self_attr_after_create current_user, key_apply = nil
    self.current_user = current_user
    self.key_apply = key_apply
  end

  def valid_attribute? attribute_name
    self.valid?
    self.errors[attribute_name].blank?
  end

  private

  def create_activity_notify
    self.save_activity :create, current_user
    Notification.create_notification key_apply, self, current_user, self.user.company_id if current_user || key_apply
    AppliesUserJob.perform_later self
    AppliesEmployerJob.perform_later self
  rescue ActiveRecord::RecordInvalid
  end

  def create_user
    return if self.user.present?
    user = User.find_by email: information[:email]
    candidate_id = if user.blank?
      applies = Apply.get_have_user.get_by_email information[:email]
      if applies.blank?
        company_apply_id = if company_id
          company_id
        elsif current_user
          current_user.company_id
        end
        user = User.auto_create_user company_apply_id, information, cv, current_user.id
        user.id
      else
        applies.first.user_id
      end
    else
      user.id
    end
    self.update_attributes user_id: candidate_id
  end
end
