require "rails_helper"

RSpec.describe Report, type: :model do
  context "associations" do
    it {is_expected.to belong_to(:reporter).class_name User.name}
    it {is_expected.to belong_to :reported}
  end
  
  context "column" do
    it {is_expected.to have_db_column(:type).of_type :integer}
    it {is_expected.to have_db_column(:reason).of_type :text}
    it {is_expected.to have_db_column(:reporter_id).of_type :integer}
    it {is_expected.to have_db_column(:reported_id).of_type :integer}
  end
end
