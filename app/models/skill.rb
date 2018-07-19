class Skill < ApplicationRecord
  acts_as_paranoid

  belongs_to :company
  has_many :knowledges, dependent: :destroy
  has_many :evaluations, through: :knowledges
  has_many :skill_sets, dependent: :destroy

  accepts_nested_attributes_for :skill_sets, reject_if: :all_blank

  validates :name, presence: true
  validates :name, uniqueness: true, if: :is_same_company?

  enum type_skill: {basic: 0, writing: 1}

  def is_same_company?
    skill = Skill.find_by name: self.name
    skill.present? && skill.company_id == self.company_id
  end
end
