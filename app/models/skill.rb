class Skill < ApplicationRecord
  acts_as_paranoid

  belongs_to :company
  has_many :knowledges, dependent: :destroy
  has_many :evaluations, through: :knowledges

  validates :name, presence: true, uniqueness: true
end
