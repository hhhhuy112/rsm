class Template < ApplicationRecord
  belongs_to :user
  enum type_of: [:template_member, :template_user]
end
