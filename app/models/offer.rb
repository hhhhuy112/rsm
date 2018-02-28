class Offer < ApplicationRecord
  belongs_to :user
  belongs_to :apply_status

  validates :salary, presence: true
  validates :start_time, presence: true
  validates :address, presence: true
  validate :start_time_cannot_be_in_the_past, if: :start_time?

  delegate :name, to: :user, prefix: true, allow_nil: true

  scope :get_newest, ->{order created_at: :desc}

  def start_time_cannot_be_in_the_past
    if start_time < DateTime.now
      errors.add :start_time, I18n.t(".start_time_cannot_be_in_the_past")
    end
  end
end
