class Survey < ApplicationRecord
  acts_as_paranoid

  belongs_to :question
  belongs_to :job
  has_many :answers, dependent: :destroy

  accepts_nested_attributes_for :question, allow_destroy: true

  delegate :name, to: :question, prefix: true, allow_nil: true

  scope :get_by_not_question, ->question_id{where.not question_id: question_id}
end
