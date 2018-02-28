require "rails_helper"

RSpec.describe Achievement, type: :model do
  context "associations" do
    it {is_expected.to belong_to :user}
  end

  context "columns" do
    it {is_expected.to have_db_column(:name).of_type :string}
    it {is_expected.to have_db_column(:majors).of_type :string}
    it {is_expected.to have_db_column(:organization).of_type :string}
    it {is_expected.to have_db_column(:received_time).of_type :date}
    it {is_expected.to have_db_column(:user_id).of_type :integer}
  end
  
  context "validates" do
    it {is_expected.to validate_presence_of :name}
    it {is_expected.to validate_presence_of :majors}
    it {is_expected.to validate_presence_of :organization}
    it {is_expected.to validate_presence_of :received_time}
  end
end
