class EmailSent < ApplicationRecord
  belongs_to :apply_status, class_name: ApplyStatus.name, foreign_key: :type_id, optional: true
  belongs_to :user

  delegate :picture, :name, to: :user, prefix: true, allow_nil: true

  self.inheritance_column = nil

  validates :title, presence: true
  validates :content, presence: true
  validates :sender_email, presence: true
  validates :receiver_email, presence: true
  validates :type, presence: true

  after_save :send_mail
  after_update :send_mail

  def send_mail
    self.user.oauth.check_access_token
    @sendmail_service = SendmailService.new self, self.user.companies.last, self.user
    @sendmail_service.send_candidate
  end
end
