class Template < ApplicationRecord
  acts_as_paranoid

  belongs_to :user
  belongs_to :company

  validates :name, presence: true, uniqueness: {scope: :company_id}
  validates :title, presence: true
  validates :type_of, presence: true
  validates :template_body, presence: true

  enum type_of: [:template_member, :template_user, :template_benefit]

  scope :get_newest, ->{order created_at: :desc}
  scope :get_not_benefit, ->{where.not type_of: :template_benefit}
end
