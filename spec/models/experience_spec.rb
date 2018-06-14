require "rails_helper"

RSpec.describe Experience, type: :model do

  let(:company){FactoryGirl.create :company}
  let(:user) {FactoryGirl.create :user, company_id: company.id}
  let(:experience) {FactoryGirl.create :experience, user_id: user.id}

  subject {experience}

  before :each do
    @exp = Experience.create(name: Faker::Name.name, company: Faker::Company.name, user_id: user.id,
      start_time: Time.zone.today - 1, end_time:Time.zone.today)
  end

  context "associations" do
    it {is_expected.to belong_to :user}
  end

  context "columns" do
    it {is_expected.to have_db_column(:name).of_type(:string)}
    it {is_expected.to have_db_column(:company).of_type(:string)}
    it {is_expected.to have_db_column(:start_time).of_type(:date)}
    it {is_expected.to have_db_column(:end_time).of_type(:date)}
    it {is_expected.to have_db_column(:project_detail).of_type(:text)}
    it {is_expected.to have_db_column(:user_id).of_type(:integer)}
  end

  context "validates" do
    it {is_expected.to validate_presence_of(:name)
      .with_message(I18n.t("activerecord.errors.models.experience.attributes.name.blank"))}
    it {is_expected.to validate_length_of(:name).is_at_most(150)
      .with_message(I18n.t("activerecord.errors.models.experience.attributes.name.too_long"))}
    it {is_expected.to validate_presence_of(:user_id)
      .with_message(I18n.t("activerecord.errors.models.experience.attributes.user_id.blank"))}
    it {is_expected.to validate_presence_of(:company)
      .with_message(I18n.t("activerecord.errors.models.experience.attributes.company.blank"))}
    it {is_expected.to validate_length_of(:company).is_at_most(150)
      .with_message(I18n.t("activerecord.errors.models.experience.attributes.company.too_long"))}

    context "start date is exists" do
      before {allow(experience).to receive(:start_time?).and_return(true)}

      it {is_expected.to validate_presence_of(:end_time)
        .with_message(I18n.t("activerecord.errors.models.experience.attributes.end_time.blank"))}
      context "end_date_after_start_date" do
        it {@exp.end_time.should > @exp.start_time}
      end
    end

    context "project details is present" do
      before {allow(experience).to receive(:project_detail?).and_return(true)}

      it {is_expected.to validate_length_of(:project_detail).is_at_least(20)
        .with_message(I18n.t("activerecord.errors.models.experience.attributes.project_detail.too_short"))}
      it {is_expected.to validate_length_of(:project_detail).is_at_most(5000)
        .with_message(I18n.t("activerecord.errors.models.experience.attributes.project_detail.too_long"))}
    end

    context "date less than today" do
      it {@exp.start_time.should <= Time.zone.today}
      it {@exp.end_time.should <= Time.zone.today}
    end
  end
end
