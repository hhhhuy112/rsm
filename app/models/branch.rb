class Branch < ApplicationRecord
  belongs_to :company
  has_many :jobs

  VALID_PHONE_REGEX = /\A(?:\+?\d{1,3}\s*-?)?\(?(?:\d{3})?\)?[- ]?\d{3}[- ]?\d{4}\z/i
  validates :phone, presence: true, format: {with: VALID_PHONE_REGEX}, uniqueness: {case_sensitive: false}
  validates :name, presence: true
  validates :street, presence: true
  validates :province, presence: true
  validates :country, presence: true

  enum is_head_office: {branch: 0, head_office: 1}
  enum status: {active: 0, not_active: 1}

  scope :order_is_head_office_and_province_desc, ->{order is_head_office: :desc, province: :desc}
  scope :by_status, ->status {where status: status}
end
