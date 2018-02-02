class EmailSent < ApplicationRecord
  after_save :send_email

  belongs_to :apply_status, class_name: ApplyStatus.name, foreign_key: :type_id, optional: true
  belongs_to :user

  delegate :picture, :name, to: :user, prefix: true, allow_nil: true

  self.inheritance_column = nil

  validates :title, presence: true
  validates :content, presence: true
  validates :sender_email, presence: true
  validates :receiver_email, presence: true
  validates :type, presence: true


  def send_email
    @send_email_service = SendEmailService.new self, self.user.get_company
    @send_email_service.send_email
  end
end
