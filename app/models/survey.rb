class Survey < ApplicationRecord
  belongs_to :question
  belongs_to :job
  has_many :answers, dependent: :destroy

  accepts_nested_attributes_for :question, allow_destroy: true

  delegate :name, to: :question, prefix: true, allow_nil: true
end
