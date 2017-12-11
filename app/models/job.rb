class Job < ApplicationRecord
  belongs_to :user
  belongs_to :company
  has_many :applies, dependent: :destroy
  has_many :feedbacks
  has_many :bookmark_likes
  has_many :reward_benefits, dependent: :destroy, inverse_of: :job

  accepts_nested_attributes_for :reward_benefits, allow_destroy: true,
    reject_if: ->(attrs){attrs["content"].blank?}

  validates :content, presence: true
  validates :name, presence: true
  validates :level, presence: true
  validates :description, presence: true
  validates :language, presence: true
  validates :position, presence: true
  validates :skill, presence: true
  validates :min_salary, presence: true
  validates :max_salary, presence: true
  validate :max_salary_less_than_min_salary
  scope :sort_lastest, ->{order(created_at: :desc)}

  private

  def max_salary_less_than_min_salary
    return if min_salary.blank? || max_salary.blank?
    errors.add :max_salary, I18n.t("jobs.validates.check_max_salary") if max_salary < min_salary
  end
end
