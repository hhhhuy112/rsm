require "rails_helper"

RSpec.describe RewardBenefit, type: :model do
  let!(:company) {FactoryGirl.create :company}
  let!(:branch) {FactoryGirl.create :branch, company_id: company.id}
  let!(:category) {FactoryGirl.create :category, company_id: company.id}

  let!(:job) do
    FactoryGirl.create :job, company_id: company.id,
      branch_id: branch.id, category_id: category.id
  end

  let(:reward_benefit) { FactoryGirl.create :reward_benefit, job_id: job.id }
  subject {reward_benefit}

  context "associations" do
    it {is_expected.to belong_to :job}
  end

  context "column" do
    it {is_expected.to have_db_column(:content).of_type(:text)}
    it {is_expected.to have_db_column(:job_id).of_type(:integer)}
  end

  context "when content is not valid" do
    before {subject.content = Settings.rspec.blank}
    it "matches the error message" do
      subject.valid?
      subject.errors[:content].should include I18n.t("activerecord.errors.models.reward_benefit.attributes.content.blank")
    end
  end
end
