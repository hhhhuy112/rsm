class Question < ApplicationRecord
  belongs_to :company

  has_many :surveys
  has_many :jobs, through: :surveys

  validates :name, presence: true

  scope :get_newest, ->{order created_at: :desc}
  scope :get_name, ->(name_cont){where "name LIKE ?", "%#{name_cont}%"}
end
