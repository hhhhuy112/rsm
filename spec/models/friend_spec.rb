require "rails_helper"

RSpec.describe Friend, type: :model do
  context "associations" do
    it {is_expected.to belong_to :user}
  end

  context "columns" do
    it {is_expected.to have_db_column(:status).of_type :boolean}
    it {is_expected.to have_db_column(:friend_id).of_type :integer}
    it {is_expected.to have_db_column(:user_id).of_type :integer}
  end
end
