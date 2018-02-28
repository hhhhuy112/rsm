class Member < ApplicationRecord
  acts_as_paranoid

  belongs_to :company
  belongs_to :user
  has_many :project_members, dependent: :destroy
  validates :start_time, presence: true
  validates :position, presence: true
  validate :date_less_than_today
  validate :end_date_after_start_date

  enum role: %i(user employer)

  scope :sort_by_updated, ->{order(updated_at: :desc)}
  scope :get_by_role, ->(role){where role: role}
  scope :search_relation, ->role, user_id do
    where("role = ? AND user_id = ? AND end_time IS ?", role, user_id, nil)
  end

  private

  def end_date_after_start_date
    return if end_time.blank? || start_time.blank?
    errors.add :end_time, I18n.t("member_date1") if end_time < start_time
  end

  def date_less_than_today
    if end_time.present?
      errors.add :end_time, I18n.t("member_date2") if end_time > Time.zone.today
    end
    return if start_time.blank?
    errors.add :start_time, I18n.t("memeber_date2") if start_time > Time.zone.today
  end
end
