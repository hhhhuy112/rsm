require "rails_helper"

RSpec.describe RewardBenefit, type: :model do

  let(:reward_benefit) { FactoryGirl.create :reward_benefit }
  subject {reward_benefit}

  context "associations" do
    it {is_expected.to belong_to :job}
  end

  context "column" do
    it {is_expected.to have_db_column(:content).of_type(:text)}
    it {is_expected.to have_db_column(:job_id).of_type(:integer)}
  end

  context "when content is not valid" do
    before {subject.content = ""}
    it "matches the error message" do
      subject.valid?
      subject.errors[:content].should include("can't be blank")
    end
  end
end
