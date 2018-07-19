class InterviewType < ApplicationRecord
  acts_as_paranoid

  belongs_to :company
  has_many :evaluations
  has_many :skill_sets, dependent: :destroy
  has_many :skills, through: :skill_sets

  accepts_nested_attributes_for :skill_sets, reject_if: :all_blank

  validates :name, presence: true
  validates :name, uniqueness: true, if: :is_same_company?

  def is_same_company?
    interview_type = InterviewType.find_by name: self.name
    interview_type.present? && interview_type.company_id == self.company_id
  end
end
