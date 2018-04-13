class EmailSent < ApplicationRecord
  acts_as_paranoid

  belongs_to :apply_status, class_name: ApplyStatus.name, foreign_key: :type_id, optional: true
  belongs_to :user
  has_one :apply, through: :apply_status
  has_one :status_step, through: :apply_status
  has_one :job, through: :apply

  enum status: %i(failure success)

  delegate :id, :picture, :name, :email, to: :user, prefix: true, allow_nil: true
  delegate :name, to: :job, prefix: true, allow_nil: true
  delegate :information, to: :apply, prefix: true, allow_nil: true

  self.inheritance_column = nil

  validates :title, presence: true
  validates :content, presence: true
  validates :sender_email, presence: true
  validates :receiver_email, presence: true
  validates :type, presence: true

  after_save :send_mail
  after_update :send_mail

  include PublicActivity::Model

  scope :newest, ->{order created_at: :desc}

  def send_mail user = nil
    @sendmail_service = SendmailService.new self, self.user.companies.last
    @sendmail_service.send_candidate user
  end

  def save_activity key, user
    self.transaction do
      self.create_activity key, owner: user, recipient: self.apply
    end
  rescue
  end
end
