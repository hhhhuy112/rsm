require "rails_helper"

RSpec.describe Achievement, type: :model do

  let(:company){FactoryGirl.create :company}
  let(:user){FactoryGirl.create :user, email: Faker::Internet.email, company_id: company.id,
    cv: Rails.root.join("public/uploads/user/cv/1/abc.pdf").open}
  let(:achievement) {FactoryGirl.create :achievement, user_id: user.id}

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

  context "validates" do
    it {is_expected.to validate_presence_of(:name)
      .with_message(I18n.t("activerecord.errors.models.achievement.attributes.name.blank"))}
    it {is_expected.to validate_presence_of(:majors)
      .with_message(I18n.t("activerecord.errors.models.achievement.attributes.majors.blank"))}
    it {is_expected.to validate_presence_of(:organization)
      .with_message(I18n.t("activerecord.errors.models.achievement.attributes.organization.blank"))}
    it {is_expected.to validate_presence_of(:received_time)
      .with_message(I18n.t("activerecord.errors.models.achievement.attributes.received_time.blank"))}
  end
end
