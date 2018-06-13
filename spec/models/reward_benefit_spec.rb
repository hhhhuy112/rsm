require "rails_helper"

RSpec.describe RewardBenefit, type: :model do
  let(:company){FactoryGirl.create :company}
  let(:user) {FactoryGirl.create :user, company_id: company.id}
  let(:branch) {FactoryGirl.create :branch, company_id: company.id}
  let(:category) {FactoryGirl.create :category, company_id: company.id}
  let(:currency) {FactoryGirl.create :currency, company_id: company.id}

  let(:job) do
    FactoryGirl.create :job, company_id: company.id, user_id: user.id,
      branch_id: branch.id, category_id: category.id, currency_id: currency.id
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

  context "validates" do
    it {is_expected.to validate_presence_of(:content)
      .with_message(I18n.t("activerecord.errors.models.reward_benefit.attributes.content.blank"))}
  end
end
