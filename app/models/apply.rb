class Apply < ApplicationRecord
  belongs_to :job
  belongs_to :user, optional: true
  has_one :company, through: :job
  has_one :appointment
  validates :cv, presence: true
  validates :information, presence: true
  enum status: {waitting: 0, review_passed: 1, review_not_selected: 2,
    test_scheduled: 3, test_passed: 4, test_not_selected: 5,
    interview_scheduled: 6, interview_passed: 7, interview_not_selected: 8,
    offer_sent: 9, offer_accepted: 10, offer_declined: 11, joined: 12}

  accepts_nested_attributes_for :appointment, allow_destroy: true

  serialize :information, Hash
  scope :newest_apply, ->{order :created_at}
  mount_uploader :cv, CvUploader

  validates_hash_keys :information do
    validates :name, presence: true
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, format: {with: VALID_EMAIL_REGEX}
    validates :phone, presence: true
    validates :introducing, presence: true
  end

  def of_user? user
    false if user.blank?
    user.id == self.user_id
  end
end
