require "rails_helper"

RSpec.describe Job, type: :model do
  let(:company){FactoryGirl.create :company}
  let(:user) {FactoryGirl.create :user, company_id: company.id}
  let(:branch) {FactoryGirl.create :branch, company_id: company.id}
  let(:category) {FactoryGirl.create :category, company_id: company.id}

  let(:job) do
    FactoryGirl.create :job, company_id: company.id, branch_id: branch.id,
      category_id: category.id, currency_id: currency.id, user_id: user.id
  end
  let(:currency) do
    FactoryGirl.create :currency, company_id: company.id
  end

  subject {job}

  context "associations" do
    it {is_expected.to belong_to :user}
    it {is_expected.to belong_to :company}
    it {is_expected.to belong_to :branch}
    it {is_expected.to belong_to :category}
    it {is_expected.to belong_to :currency}
    it {is_expected.to have_many :applies}
    it {is_expected.to have_many :feedbacks}
    it {is_expected.to have_many :bookmark_likes}
    it {is_expected.to have_many :reward_benefits}
  end

  context "columns" do
    it {is_expected.to have_db_column(:content).of_type(:text)}
    it {is_expected.to have_db_column(:name).of_type(:string)}
    it {is_expected.to have_db_column(:level).of_type(:string)}
    it {is_expected.to have_db_column(:language).of_type(:string)}
    it {is_expected.to have_db_column(:skill).of_type(:text)}
    it {is_expected.to have_db_column(:position).of_type(:string)}
    it {is_expected.to have_db_column(:user_id).of_type(:integer)}
    it {is_expected.to have_db_column(:company_id).of_type(:integer)}
    it {is_expected.to have_db_column(:description).of_type(:text)}
    it {is_expected.to have_db_column(:position_types).of_type(:integer)}
    it {is_expected.to have_db_column(:branch_id).of_type(:integer)}
    it {is_expected.to have_db_column(:category_id).of_type(:integer)}
    it {is_expected.to have_db_column(:min_salary).of_type(:float)}
    it {is_expected.to have_db_column(:max_salary).of_type(:float)}
    it {is_expected.to have_db_column(:end_time).of_type(:date)}
  end

  context "validates" do
    it {is_expected.to validate_presence_of(:name)
      .with_message(I18n.t("activerecord.errors.models.job.attributes.name.blank"))}
    it {is_expected.to validate_presence_of(:description)
      .with_message(I18n.t("activerecord.errors.models.job.attributes.description.blank"))}
    it {is_expected.to validate_presence_of(:min_salary)
      .with_message(I18n.t("activerecord.errors.models.job.attributes.min_salary.blank"))}
    it {is_expected.to validate_presence_of(:branch_id)
      .with_message(I18n.t("activerecord.errors.models.job.attributes.branch_id.blank"))}
    it {is_expected.to validate_presence_of(:target)
      .with_message(I18n.t("activerecord.errors.models.job.attributes.target.blank"))}
    it {is_expected.to validate_presence_of(:category_id)
      .with_message(I18n.t("activerecord.errors.models.job.attributes.category_id.blank"))}
    it {is_expected.to validate_presence_of(:survey_type)
      .with_message(I18n.t("activerecord.errors.models.job.attributes.survey_type.blank"))}
  end

  context "when max_salary_less_than_min_salary is not valid" do
    before do
      subject.max_salary = Settings.rspec.job_spec.max_salary
      subject.min_salary = Settings.rspec.job_spec.min_salary
    end
    it "matches the error message" do
      subject.valid?
      subject.errors[:max_salary].should include I18n.t("jobs.validates.check_max_salary")
    end
  end

  context "when max_salary_equal_than_min_salary is valid" do
    before do
      subject.max_salary = Settings.rspec.job_spec.salary
      subject.min_salary = Settings.rspec.job_spec.salary
    end
    it {is_expected.not_to be_invalid}
  end

  context "nested attributes for reward_benefits" do
    it "exits accept_nested_attributes_for reward_benefits " do
      should accept_nested_attributes_for(:reward_benefits)
      should accept_nested_attributes_for(:reward_benefits).allow_destroy(true)
    end
  end

  context "when content of reward benefit is blank" do
    it "destroy reward benefit" do
      params = {
        content: Faker::Lorem.name, name: Faker::Lorem.paragraphs,
        level: Faker::University.name,
        language: Faker::Lorem.word,
        skill: Faker::Lorem.word, position: Faker::Lorem.word,
        company_id: company.id, description: Faker::Lorem.paragraphs,
        min_salary: Settings.rspec.job_spec.min_salary, max_salary: Settings.rspec.job_spec.salary,
        reward_benefits_attributes: [{content: ""}]
      }
      job_natb = Job.create params

      expect(job_natb.reward_benefits).to be_empty
    end
  end

  context "when content of reward benefit is blank is not destroy" do
    it "create reward benefit" do
      params = {
        content: Faker::Lorem.name, name: Faker::Lorem.paragraphs,
        level: Faker::University.name,
        language: Faker::Lorem.word,
        skill: Faker::Lorem.word, position: Faker::Lorem.word,
        company_id: company.id, description: Faker::Lorem.paragraphs,
        min_salary: Settings.rspec.job_spec.min_salary, max_salary: Settings.rspec.job_spec.salary,
        reward_benefits_attributes: [{content: Faker::Lorem.word}]
      }
      job_natb = Job.create params

      expect(job_natb.reward_benefits).to_not be_empty
    end
  end
end
