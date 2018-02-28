require "rails_helper"

RSpec.describe Achievement, type: :model do
  let(:achievement) {FactoryGirl.create :achievement}
  subject {achievement}

  context "associations" do
    it {is_expected.to belong_to :user}
  end

  context "columns" do
    it {is_expected.to have_db_column(:name).of_type(:string)}
    it {is_expected.to have_db_column(:majors).of_type(:string)}
    it {is_expected.to have_db_column(:organization).of_type(:string)}
    it {is_expected.to have_db_column(:received_time).of_type(:date)}
    it {is_expected.to have_db_column(:user_id).of_type(:integer)}
  end

  context "when name is not valid" do
    before {subject.name = ""}
    it {is_expected.not_to be_valid}
  end

  context "when majors is not valid" do
    before {subject.majors = ""}
    it {is_expected.not_to be_valid}
  end

  context "when organization is not valid" do
    before {subject.organization = ""}
    it {is_expected.not_to be_valid}
  end
end
