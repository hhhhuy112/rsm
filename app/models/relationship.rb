class Relationship < ApplicationRecord
  acts_as_paranoid

  belongs_to :follower, class_name: User.name
  belongs_to :followed, polymorphic: true
end
