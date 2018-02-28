class Experience < ApplicationRecord
  acts_as_paranoid

  belongs_to :user
  validates :name, presence: true, length: {maximum: Settings.experiences.model.name_max_length}
  validates :user_id, presence: true
  validates :company, presence: true, length: {maximum: Settings.experiences.model.company_max_length}
  validates :end_time, presence: true, if: :start_time?
  validates :start_time, presence: true, if: :end_time?
  validates :project_detail, length: {maximum: Settings.experiences.model.detail_max_length, minimum:
    Settings.experiences.model.detail_min_length}, if: :project_detail?
  validate :date_less_than_today
  validate :end_date_after_start_date

  private

  def end_date_after_start_date
    return if end_time.blank? || start_time.blank?
    errors.add :end_time, I18n.t("validates.end_before_start") if end_time < start_time
  end

  def date_less_than_today
    if end_time.present?
      errors.add :end_time, I18n.t("validates.end_time_future") if end_time > Time.zone.today
    end
    return if start_time.blank?
    errors.add :start_time, I18n.t("validates.start_time_future") if start_time > Time.zone.today
  end
end
