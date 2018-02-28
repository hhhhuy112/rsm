class Job < ApplicationRecord
  acts_as_paranoid
  attr_accessor :question_ids

  belongs_to :user
  belongs_to :company
  has_many :applies, dependent: :destroy
  has_many :feedbacks, dependent: :destroy
  has_many :bookmark_likes, dependent: :destroy
  has_many :reward_benefits, dependent: :destroy, inverse_of: :job
  has_many :apply_statuses, through: :applies
  has_many :surveys, dependent: :destroy
  has_many :questions, through: :surveys
  belongs_to :branch
  belongs_to :category

  after_create :create_survey, unless: :survey_not_exist?

  accepts_nested_attributes_for :reward_benefits, allow_destroy: true,
    reject_if: ->(attrs){attrs["content"].blank?}
  accepts_nested_attributes_for :surveys, allow_destroy: true

  validates :name, presence: true
  validates :description, presence: true
  validates :min_salary, presence: true
  validates :position, presence: true
  validates :branch_id, presence: true
  validates :target, presence: true
  validates :category_id, presence: true
  validate :max_salary_less_than_min_salary
  validates :survey_type, presence: true

  enum position_types: {full_time_freshers: 0, full_time_careers: 1, part_time: 2, intern: 3, freelance: 4}
  enum status: [:opend, :closed]
  enum survey_type: [:not_exist, :optional, :compulsory]

  scope :sort_max_salary_and_target, -> do
    order(max_salary: :desc, target: :desc).limit Settings.job.limit
  end
  scope :job_company, -> company {where company_id: company}
  scope :sort_lastest, -> {order updated_at: :desc}
  scope :get_top_jobs, -> company {where company_id: company}
  scope :urgent_jobs, -> date_now, date_compare do
    where "end_time >= ? AND end_time <= ?", date_now, date_compare
  end
  scope :unexpired_jobs, -> date_compare {where "end_time >= ? OR end_time IS NULL", date_compare}
  scope :expired_jobs, -> date_compare {where "end_time < ?", date_compare}

  delegate :id, to: :company, prefix: true, allow_nil: true

  include PublicActivity::Model

  def save_activity user, key
    self.transaction do
      self.create_activity key, owner: user
    end
  rescue
  end

  class << self
    def count_of_company company
      job_company(company.id).count
    end

    def count_top_of_company company
      get_top_jobs(company.id).sort_max_salary_and_target.count
    end

    def count_urgent_of_company company
      job_company(company.id)
        .urgent_jobs(Time.zone.now.to_date, Time.zone.now.to_date + Settings.job.urrency.days).count
    end

    def count_expired_of_company company
      job_company(company.id).expired_jobs(Time.zone.now.to_date).count
    end
  end

  def self_attr_after_create question_ids
    self.question_ids = question_ids
  end

  def survey_not_exist?
    self.not_exist?
  end

  private

  def max_salary_less_than_min_salary
    return if min_salary.blank? || max_salary.blank?
    errors.add :max_salary, I18n.t("jobs.validates.check_max_salary") if max_salary < min_salary
  end

  def create_survey
    questions = []
    question_ids.each_with_index do |id, i|
      next if id.blank?
      questions << self.surveys.build(question_id: id)
    end
    Survey.transaction do
      Survey.import! questions
    end
  end
end
