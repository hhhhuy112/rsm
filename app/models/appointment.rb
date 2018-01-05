class Appointment < ApplicationRecord
  belongs_to :company
  belongs_to :apply
  has_many :inforappointments, dependent: :destroy
  has_many :user, through: :inforappointments
  validates :start_time, presence: true
  validates :end_time, presence: true
  validates :address, presence: true
  validate :date_less_than_today
  validate :end_date_after_start_date

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
end
