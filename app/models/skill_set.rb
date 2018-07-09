class SkillSet < ApplicationRecord
  acts_as_paranoid

  belongs_to :interview_type
  belongs_to :skill
end
