require "rails_helper"

RSpec.describe Job, type: :model do
  let(:job) {FactoryGirl.create :job}
  subject {job}

  context "associations" do
    it {should belong_to :user}
    it {should belong_to :company}
    it {is_expected.to have_many :applies}
    it {is_expected.to have_many :feedbacks}
    it {is_expected.to have_many :bookmark_likes}
    it {is_expected.to have_many :reward_benefits}
  end

  context "columns" do
    it {should have_db_column(:content).of_type(:text)}
    it {should have_db_column(:name).of_type(:string)}
    it {should have_db_column(:level).of_type(:string)}
    it {should have_db_column(:language).of_type(:string)}
    it {should have_db_column(:skill).of_type(:string)}
    it {should have_db_column(:position).of_type(:string)}
    it {should have_db_column(:user_id).of_type(:integer)}
    it {should have_db_column(:company_id).of_type(:integer)}
  end

  context "validates" do
    it {is_expected.to validate_presence_of(:content)}
    it {is_expected.to validate_presence_of(:name)}
    it {is_expected.to validate_presence_of(:level)}
    it {is_expected.to validate_presence_of(:description)}
    it {is_expected.to validate_presence_of(:language)}
    it {is_expected.to validate_presence_of(:position)}
    it {is_expected.to validate_presence_of(:skill)}
  end

  context "when name is not valid" do
    before {subject.name = ""}
    it {is_expected.not_to be_valid}
  end

  context "when content is not valid" do
    before {subject.content = ""}
    it {is_expected.not_to be_valid}
  end

  context "when level is not valid" do
    before {subject.level = ""}
    it {is_expected.not_to be_valid}
  end

  context "when description is not valid" do
    before {subject.description = ""}
    it {is_expected.not_to be_valid}
  end

  context "when language is not valid" do
    before {subject.language = ""}
    it {is_expected.not_to be_valid}
  end

  context "when position is not valid" do
    before {subject.position = ""}
    it {is_expected.not_to be_valid}
  end

  context "when skill is not valid" do
    before {subject.skill = ""}
    it {is_expected.not_to be_valid}
  end
end
