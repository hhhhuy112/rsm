require "rails_helper"

RSpec.describe Relationship, type: :model do
  context "associations" do
    it {is_expected.to belong_to(:follower).class_name User.name}
    it {is_expected.to belong_to :followed}
  end

  context "column" do
    it {is_expected.to have_db_column(:follower_id).of_type :integer}
    it {is_expected.to have_db_column(:followed_id).of_type :integer}
    it {is_expected.to have_db_column(:type).of_type :integer}
  end
end
