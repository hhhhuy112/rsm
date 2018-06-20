require "rails_helper"

RSpec.describe Company, type: :model do

  let(:company){FactoryGirl.create :company, name: Faker::Company.name,
    majors: Faker::Company.industry, contact_person: Faker::Name.name,
    phone: Faker::Number.number(10)}

  subject {company}

  context "associations" do
    it {is_expected.to have_many :appointments}
    it {is_expected.to have_many :projects}
    it {is_expected.to have_many :jobs}
    it {is_expected.to have_many :members}
    it {is_expected.to have_many :passive_report}
    it {is_expected.to have_many :passive_follow}
    it {is_expected.to have_many :currencies}
    it {is_expected.to have_many :templates}
    it {is_expected.to have_many :skills}
  end

  context "columns" do
    it {is_expected.to have_db_column(:name).of_type(:string)}
    it {is_expected.to have_db_column(:address).of_type(:text)}
    it {is_expected.to have_db_column(:phone).of_type(:string)}
    it {is_expected.to have_db_column(:majors).of_type(:string)}
  end

  context "validates" do
    it {is_expected.to validate_presence_of(:name)
      .with_message(I18n.t("activerecord.errors.models.company.attributes.name.blank"))}
    it {is_expected.to validate_presence_of(:majors)
      .with_message(I18n.t("activerecord.errors.models.company.attributes.majors.blank"))}
    it {is_expected.to validate_presence_of(:contact_person)
      .with_message(I18n.t("activerecord.errors.models.company.attributes.contact_person.blank"))}
    it {is_expected.to validate_presence_of(:phone)
      .with_message(I18n.t("activerecord.errors.models.company.attributes.phone.blank"))}
    it {is_expected.to validate_uniqueness_of(:phone).case_insensitive
      .with_message(I18n.t("activerecord.errors.models.company.attributes.phone.already_exist"))}
  end
end
