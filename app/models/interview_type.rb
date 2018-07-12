class InterviewType < ApplicationRecord
  acts_as_paranoid

  belongs_to :company
  has_many :evaluations
  has_many :skill_sets, dependent: :destroy
  has_many :skills, through: :skill_sets

  accepts_nested_attributes_for :skill_sets, reject_if: :all_blank

  validates :name, presence: true, uniqueness: true
end
