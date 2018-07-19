class SkillSet < ApplicationRecord
  acts_as_paranoid

  belongs_to :interview_type
  belongs_to :skill

  accepts_nested_attributes_for :skill, reject_if: :all_blank

  delegate :name, to: :skill, prefix: true, allow_nil: true

  scope :of_interview_type, ->(interview_type_id){where interview_type_id: interview_type_id}
end
