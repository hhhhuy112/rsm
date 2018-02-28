require "rails_helper"

RSpec.describe Certificate, type: :model do
  let(:certificate) {FactoryGirl.create :certificate}
  subject {certificate}

  context "associations" do
    it {is_expected.to belong_to :user}
  end

  context "validates" do
    it {is_expected.to validate_presence_of :name}
    it {is_expected.to validate_length_of(:name).is_at_most(Settings.certificate.maximum)}
    it {is_expected.to validate_presence_of :majors}
    it {is_expected.to validate_length_of(:majors).is_at_most(Settings.certificate.maximum)}
    it {is_expected.to validate_presence_of :organization}
    it {is_expected.to validate_length_of(:organization).is_at_most(Settings.certificate.maximum)}
    it {is_expected.to validate_length_of(:classification).is_at_most(Settings.certificate.maximum)}
    it {is_expected.to validate_presence_of :received_time}
  end

  context "columns" do
    it {is_expected.to have_db_column(:name).of_type(:string)}
    it {is_expected.to have_db_column(:majors).of_type(:string)}
    it {is_expected.to have_db_column(:organization).of_type(:string)}
    it {is_expected.to have_db_column(:classification).of_type(:string)}
    it {is_expected.to have_db_column(:received_time).of_type(:date)}
    it {is_expected.to have_db_column(:user_id).of_type(:integer)}
  end

  context "when name is not valid" do
    before {subject.name = ""}
    it "matches the error message" do
      subject.valid?
      subject.errors[:name].should include I18n.t("activerecord.errors.models.certificate.attributes.name.blank")
    end
  end

  context "when majors is not valid" do
    before {subject.majors = ""}
    it "matches the error message" do
      subject.valid?
      subject.errors[:majors].should include I18n.t("activerecord.errors.models.certificate.attributes.majors.blank")
    end
  end

  context "when organization is not valid" do
    before {subject.organization = ""}
    it "matches the error message" do
      subject.valid?
      subject.errors[:organization].should include I18n.t("activerecord.errors.models.certificate.attributes.organization.blank")
    end
  end

  context "when received_time is not valid" do
    before {subject.received_time = ""}
    it "matches the error message" do
      subject.valid?
      subject.errors[:received_time].should include I18n.t("activerecord.errors.models.certificate.attributes.received_time.blank")
    end
  end

  context "when name is too long" do
    before {subject.name = Faker::Lorem.characters(260)}
    it "matches the error message" do
      subject.valid?
      subject.errors[:name].should include I18n.t("activerecord.errors.models.certificate.attributes.name.too_long")
    end
  end

  context "when majors is too long" do
    before {subject.majors = Faker::Lorem.characters(260)}
    it "matches the error message" do
      subject.valid?
      subject.errors[:majors].should include I18n.t("activerecord.errors.models.certificate.attributes.majors.too_long")
    end
  end

  context "when organization is too long" do
    before {subject.organization = Faker::Lorem.characters(260)}
    it "matches the error message" do
      subject.valid?
      subject.errors[:organization].should include I18n.t("activerecord.errors.models.certificate.attributes.organization.too_long")
    end
  end

  context "when classification is too long" do
    before {subject.classification = Faker::Lorem.characters(260)}
    it "matches the error message" do
      subject.valid?
      subject.errors[:classification].should include I18n.t("activerecord.errors.models.certificate.attributes.classification.too_long")
    end
  end
end
