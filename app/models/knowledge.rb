class Knowledge < ApplicationRecord
  acts_as_paranoid

  belongs_to :evaluation
  belongs_to :skill

  validates :writing_evaluation, presence: true, allow_nil: true

  accepts_nested_attributes_for :skill, reject_if: :all_blank

  delegate :name, to: :skill, allow_nil: true, prefix: true

  enum score: {not_evaluate: 0, bad: 1, medium: 2, rather: 3, good: 4, excellent: 5}
end
