class Answer < ApplicationRecord
  belongs_to :apply, required: true
  belongs_to :survey, required: true

  validates :name, presence: true, if: Proc.new { |answer|
    answer.survey_job.compulsory?
  }

  delegate :job, to: :survey, prefix: true, allow_nil: true
end
