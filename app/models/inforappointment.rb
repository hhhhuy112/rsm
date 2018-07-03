class Inforappointment < ApplicationRecord
  acts_as_paranoid

  attr_accessor :activation_token

  belongs_to :user
  belongs_to :appointment

  delegate :name, :email, to: :user, allow_nil: true, prefix: true

  scope :get_by, -> appointment_ids do
    where appointment_id: appointment_ids
  end

  def create_activation_digest
    self.activation_token  = Inforappointment.new_token
    self.activation_digest = Inforappointment.digest(activation_token)
  end

  class << self
    def new_token
      SecureRandom.urlsafe_base64
    end

    def digest string
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                    BCrypt::Engine.cost
      BCrypt::Password.create(string, cost: cost)
    end

    def appointment_ids inforappointments
      inforappointments.map(&:appointment_id).uniq
    end
  end
end
