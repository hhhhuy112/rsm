class Evaluation < ApplicationRecord
  acts_as_paranoid

  belongs_to :apply
  has_many :knowledges, inverse_of: :evaluation, dependent: :destroy
  has_many :skills, through: :knowledges

  accepts_nested_attributes_for :knowledges, allow_destroy: true

  include PublicActivity::Model

  class << self
    def apply_ids evaluations
      evaluations.map(&:apply_id).uniq
    end

    def skill_ids evaluations
      ids = []
      evaluations.each do |evaluation|
        ids = ids + evaluation.skill_ids
      end
      ids.uniq
    end
  end

  def save_activity key, user
    self.transaction do
      self.create_activity key, owner: user, recipient: self.apply
    end
  end
end
