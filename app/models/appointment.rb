class Appointment < ApplicationRecord
  acts_as_paranoid

  belongs_to :company
  belongs_to :apply_status
  has_many :inforappointments, dependent: :destroy
  has_many :users, through: :inforappointments
  has_one :apply, through: :apply_status
  has_one :job, through: :apply

  validates :start_time, presence: true
  validates :end_time, presence: true
  validates :address, presence: true
  validate :date_less_than_today
  validate :end_date_after_start_date

  before_save :convert_time

  enum type_appointment: {test_scheduled: 0, interview_scheduled: 1}

  delegate :name, to: :job, prefix: true, allow_nil: true

  scope :get_greater_equal_by, -> (date) do
    where("start_time >= ?", date)
  end

  scope :get_by, -> apply_status_ids do
    where apply_status_id: apply_status_ids
  end

  scope :newest, ->{order created_at: :desc}

 private

  def end_date_after_start_date
    return if end_time.blank? || start_time.blank?
    errors.add :end_time, I18n.t("clubs.model.date1") if end_time < start_time
  end

  def date_less_than_today
    if end_time.present?
      errors.add :end_time, I18n.t("clubs.model.date1") if end_time < Time.zone.today
    end
  end

  def convert_time
    self.start_time = ActiveSupport::TimeZone.new(File.read("/etc/timezone").chomp).local_to_utc(self.start_time)
    self.end_time = ActiveSupport::TimeZone.new(File.read("/etc/timezone").chomp).local_to_utc(self.end_time)
  end
end
