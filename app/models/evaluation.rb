class Evaluation < ApplicationRecord
  acts_as_paranoid

  belongs_to :apply
  belongs_to :interview_type
  belongs_to :currency
  has_many :knowledges, inverse_of: :evaluation, dependent: :destroy
  has_many :skills, through: :knowledges

  accepts_nested_attributes_for :knowledges, allow_destroy: true

  delegate :sign, to: :currency, prefix: true, allow_nil: true

  validates :start_date, presence: true
  validates :expected_salary, presence: true

  include PublicActivity::Model

  def save_activity key, user
    self.transaction do
      self.create_activity key, owner: user, recipient: self.apply
    end
  end

  def self.apply_ids evaluations
    evaluations.map(&:apply_id).uniq
  end
end
