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
  end

  context "columns" do
    it {is_expected.to have_db_column(:name).of_type(:string)}
    it {is_expected.to have_db_column(:address).of_type(:text)}
    it {is_expected.to have_db_column(:phone).of_type(:string)}
    it {is_expected.to have_db_column(:majors).of_type(:string)}
  end

  context "validates" do
    it {is_expected.to validate_presence_of(:name)}
    it {is_expected.to validate_presence_of(:majors)}
    it {is_expected.to validate_presence_of(:contact_person)}
    it {is_expected.to validate_presence_of(:phone)}
  end

  context "when name is not valid" do
    before {subject.name = ""}
    it "matches the error message" do
      subject.valid?
      subject.errors[:name].should include("can't be blank")
    end
  end

  context "when majors is not valid" do
    before {subject.majors = ""}
    it "matches the error message" do
      subject.valid?
      subject.errors[:majors].should include("can't be blank")
    end
  end

  context "when contact_person is not valid" do
    before {subject.contact_person = ""}
    it "matches the error message" do
      subject.valid?
      subject.errors[:contact_person].should include("can't be blank")
    end
  end

  context "when phone is not valid" do
    before {subject.phone = ""}
    it "matches the error message" do
      subject.valid?
      subject.errors[:phone].should include("can't be blank")
    end
  end

  context "when phone is not matches regex" do
    before {subject.phone = Faker::Lorem.characters(10)}
    it "matches the error message" do
      expect(subject.phone).not_to match(/\A(?:\+?\d{1,3}\s*-?)?\(?(?:\d{3})?\)?[- ]?\d{3}[- ]?\d{4}\z/)
    end
  end
end
