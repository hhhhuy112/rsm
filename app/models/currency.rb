class Currency < ApplicationRecord
  acts_as_paranoid

  has_many :jobs
  has_many :offers
  has_many :evaluations
  belongs_to :company

  validates :nation, presence: true
  validates :unit, presence: true
  validates :sign, presence: true

  scope :get_newest, ->{order created_at: :desc}
end
