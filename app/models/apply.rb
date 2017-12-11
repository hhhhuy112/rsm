class Apply < ApplicationRecord
  belongs_to :user
  belongs_to :job
  has_one :company, through: :job
  enum status: {Not_receive: 0, Received: 1}
  scope :newest_apply, ->{order :created_at}
end
