require "rails_helper"

RSpec.describe User, type: :model do

  let(:company){FactoryGirl.create :company}
  let!(:user1){FactoryGirl.create :user, company_id: company.id}
  let(:user){FactoryGirl.create :user, email: "votri96@gmail.com", company_id: company.id}

  subject {user}

  context "associations" do
    it {is_expected.to have_many :achievements}
    it {is_expected.to have_many :clubs}
    it {is_expected.to have_many :certificates}
    it {is_expected.to have_many :experiences}
    it {is_expected.to have_many :friends}
    it {is_expected.to have_many :microposts}
    it {is_expected.to have_many :active_follow}
    it {is_expected.to have_many :passive_follow}
    it {is_expected.to have_many :active_report}
    it {is_expected.to have_many :passive_report}
    it {is_expected.to have_many :jobs}
    it {is_expected.to have_many :bookmark_likes}
    it {is_expected.to have_many :feedbacks}
    it {is_expected.to have_many :applies}
    it {is_expected.to have_many :inforappointments}
    it {is_expected.to have_many :notifications}
    it {is_expected.to have_many :members}
  end

  context "column" do
    it {is_expected.to have_db_column(:name).of_type(:string)}
    it {is_expected.to have_db_column(:birthday).of_type(:date)}
    it {is_expected.to have_db_column(:email).of_type(:string)}
    it {is_expected.to have_db_column(:phone).of_type(:string)}
    it {is_expected.to have_db_column(:address).of_type(:text)}
    it {is_expected.to have_db_column(:sex).of_type(:integer)}
    it {is_expected.to have_db_column(:role).of_type(:integer)}
  end
  context "when name is not valid" do
    before {subject.name = ""}
    it "matches the error message" do
      subject.valid?
      subject.errors[:name].should include("can't be blank")
    end
  end

  context "when email is not valid" do
    before {subject.email = user1.email}
    it "matches the error message" do
      subject.valid?
      subject.errors[:email].should include("already exist")
    end
  end

  context "when password is too short" do
    before {subject.password = Faker::Lorem.characters(2)}
    it "matches the error message" do
      subject.valid?
      subject.errors[:password].should include("is too short (minimum is 6 characters)")
    end
  end

  context "when password is too long" do
    before {subject.password = Faker::Lorem.characters(222)}
    it "matches the error message" do
      subject.valid?
      subject.errors[:password].should include("is too long (maximum is 128 characters)")
    end
  end
end
