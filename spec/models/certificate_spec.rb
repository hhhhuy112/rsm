require "rails_helper"

RSpec.describe Certificate, type: :model do
  let(:company){FactoryGirl.create :company}
  let(:user){FactoryGirl.create :user, company_id: company.id}
  let(:certificate) {FactoryGirl.create :certificate, user_id: user.id}
  subject {certificate}

  context "associations" do
    it {is_expected.to belong_to :user}
  end

  context "validates" do
    it {is_expected.to validate_presence_of(:name)
      .with_message(I18n.t("activerecord.errors.models.certificate.attributes.name.blank"))}
    it {is_expected.to validate_length_of(:name).is_at_most(Settings.certificate.maximum)
      .with_message(I18n.t("activerecord.errors.models.certificate.attributes.name.too_long"))}
    it {is_expected.to validate_presence_of(:majors)
      .with_message(I18n.t("activerecord.errors.models.certificate.attributes.majors.blank"))}
    it {is_expected.to validate_length_of(:majors).is_at_most(Settings.certificate.maximum)
      .with_message(I18n.t("activerecord.errors.models.certificate.attributes.majors.too_long"))}
    it {is_expected.to validate_presence_of(:organization)
      .with_message(I18n.t("activerecord.errors.models.certificate.attributes.organization.blank"))}
    it {is_expected.to validate_length_of(:organization).is_at_most(Settings.certificate.maximum)
      .with_message(I18n.t("activerecord.errors.models.certificate.attributes.organization.too_long"))}
    it {is_expected.to validate_length_of(:classification).is_at_most(Settings.certificate.maximum)
      .with_message(I18n.t("activerecord.errors.models.certificate.attributes.classification.too_long"))}
    it {is_expected.to validate_presence_of(:received_time)
      .with_message(I18n.t("activerecord.errors.models.certificate.attributes.received_time.blank"))}
  end

  context "columns" do
    it {is_expected.to have_db_column(:name).of_type(:string)}
    it {is_expected.to have_db_column(:majors).of_type(:string)}
    it {is_expected.to have_db_column(:organization).of_type(:string)}
    it {is_expected.to have_db_column(:classification).of_type(:string)}
    it {is_expected.to have_db_column(:received_time).of_type(:date)}
    it {is_expected.to have_db_column(:user_id).of_type(:integer)}
  end
end
