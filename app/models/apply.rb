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

  after_create :create_activity_notify, :create_user

  validates :cv, presence: true
  validates :information, presence: true
  enum status: {unlock_apply: 0, lock_apply: 1, cancel_apply: 2}

  accepts_nested_attributes_for :apply_statuses, allow_destroy: true , update_only: true
  accepts_nested_attributes_for :answers, allow_destroy: true

  scope :newest_apply, ->{order :created_at}
  scope :sort_apply, ->{order(created_at: :desc).limit Settings.job.limit}
  scope :lastest_apply, ->{order created_at: :desc}
  scope :get_by_user, -> user_id {where user_id: user_id}

  mount_uploader :cv, CvUploader

  delegate :name, to: :job, prefix: true, allow_nil: true
  delegate :name, to: :step, prefix: true, allow_nil: true
  delegate :phone, :email, :name, to: :user, prefix: true, allow_nil: true
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
    self.transaction requires_new: true do
      if params
        self.create_activity key, owner: user, parameters: {status: params}
      else
        self.create_activity key, owner: user
      end
    end
  rescue
  end

  def self_attr_after_create current_user, key_apply
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
    Notification.create_notification key_apply, self, current_user, self.job.company_id if current_user || key_apply
    AppliesUserJob.perform_later self
    AppliesEmployerJob.perform_later self
  rescue ActiveRecord::RecordInvalid
  end

  def create_user
    return if self.user.present?
    user = User.find_by email: information[:email]
    if user.blank?
      password = Devise.friendly_token.first(Settings.password.length)
      user = User.new email: information[:email], name: information[:name],
        password: password, company_id: company_id, phone: information[:phone],
        address: information[:address]
      user.self_attr_after_save password
      user.save!
    end
    self.update_attributes user_id: user.id
  rescue ActiveRecord::RecordInvalid
  end
end
