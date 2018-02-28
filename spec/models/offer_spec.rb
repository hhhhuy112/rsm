require "rails_helper"

RSpec.describe Offer, type: :model do
  context "associations" do
    it {is_expected.to belong_to :user}
    it {is_expected.to belong_to :apply_status}
  end

  context "columns" do
    it {is_expected.to have_db_column(:salary).of_type :float}
    it {is_expected.to have_db_column(:start_time).of_type :date}
    it {is_expected.to have_db_column(:address).of_type :text}
    it {is_expected.to have_db_column(:requirement).of_type :text}
    it {is_expected.to have_db_column(:user_id).of_type :integer}
    it {is_expected.to have_db_column(:apply_status_id).of_type :integer}
  end

  context "validates" do
    it {is_expected.to validate_presence_of :salary}
    it {is_expected.to validate_presence_of :start_time}
    it {is_expected.to validate_presence_of :address}
  end
end
