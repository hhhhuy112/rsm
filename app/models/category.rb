class Category < ApplicationRecord
  belongs_to :company
  has_many :jobs

  validates :name, presence: true

  enum status: {active: 0, not_active: 1}

  scope :by_status, ->status {where status: status}
  scope :order_name_desc, ->{order name: :desc}
end
