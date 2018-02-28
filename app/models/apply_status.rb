class ApplyStatus < ApplicationRecord
  belongs_to :apply
  belongs_to :status_step

  has_one :step, through: :status_step
  has_one :job, through: :apply
  has_one :appointment, dependent: :destroy
  has_many :offers, dependent: :destroy

  has_many :email_sents, class_name: EmailSent.name, foreign_key: :type_id, dependent: :destroy

  delegate :id, to: :appointment, allow_nil: true, prefix: true
  delegate :name, to: :status_step, allow_nil: true, prefix: true
  delegate :name, to: :step, allow_nil: true, prefix: true
  delegate :id, :information, :created_at, to: :apply, allow_nil: true, prefix: true
  delegate :name, to: :job, allow_nil: true, prefix: true

  accepts_nested_attributes_for :appointment, allow_destroy: true , update_only: true
  accepts_nested_attributes_for :email_sents, allow_destroy: true , update_only: true
  accepts_nested_attributes_for :offers, allow_destroy: true , update_only: true

  enum is_current: {current: 0, not_current: 1}

  include PublicActivity::Model

  scope :get_by, -> apply_ids do
    where apply_id: apply_ids
  end
  scope :lastest_apply_status, ->{order created_at: :desc}
  scope :is_step, ->id_status_step{where status_step_id: id_status_step}
  scope :of_apply, -> apply_ids {where apply_id: apply_ids}
  scope :sort_apply_statues, ->{order(created_at: :desc).limit Settings.job.limit}

  def save_activity key, user
    self.transaction do
      self.create_activity key, owner: user
    end
  end
end
