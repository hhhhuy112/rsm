class Skill < ApplicationRecord
  acts_as_paranoid

  belongs_to :company
  has_many :knowledges, dependent: :destroy
  has_many :evaluations, through: :knowledges
  has_many :skill_sets, dependent: :destroy

  accepts_nested_attributes_for :skill_sets, reject_if: :all_blank

  validates :name, presence: true, uniqueness: true

  enum type_skill: {basic: 0, writing: 1}
end
