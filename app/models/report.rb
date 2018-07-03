class Report < ApplicationRecord
  acts_as_paranoid

  belongs_to :reporter, class_name: User.name
  belongs_to :reported, class_name: User.name
end
