class CompanySetting < ApplicationRecord
  belongs_to :company, optional: true
  serialize :enable_setting, Hash
end
