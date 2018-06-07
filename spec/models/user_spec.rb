require "rails_helper"

RSpec.describe User, type: :model do

  let(:company){FactoryGirl.create :company}
  let!(:user1){FactoryGirl.create :user, company_id: company.id,
    cv: Rails.root.join("public/uploads/user/cv/1/abc.pdf").open}
  let(:user){FactoryGirl.create :user, email: Faker::Internet.email, company_id: company.id,
    cv: Rails.root.join("public/uploads/user/cv/1/abc.pdf").open}

  subject {user}

  context "associations" do
    it {is_expected.to have_many :achievements}
    it {is_expected.to have_many :clubs}
    it {is_expected.to have_many :templates}
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
    it {is_expected.to have_many :notifications}
    it {is_expected.to have_many :members}
    it {is_expected.to have_many :companies}
    it {is_expected.to have_many :applies}
    it {is_expected.to have_many :inforappointments}
    it {is_expected.to have_many :offers}
    it {is_expected.to have_one :oauth}
    it {is_expected.to have_many :apply_statuses}
    it {is_expected.to have_many :notes}
    it {is_expected.to have_many :email_sents}
    it {is_expected.to belong_to :assignment_person}
    it {is_expected.to belong_to :company}
  end

  context "column" do
    it {is_expected.to have_db_column(:name).of_type(:string)}
    it {is_expected.to have_db_column(:birthday).of_type(:date)}
    it {is_expected.to have_db_column(:email).of_type(:string)}
    it {is_expected.to have_db_column(:phone).of_type(:string)}
    it {is_expected.to have_db_column(:address).of_type(:text)}
    it {is_expected.to have_db_column(:sex).of_type(:integer)}
    it {is_expected.to have_db_column(:role).of_type(:integer)}
    it {is_expected.to have_db_column(:picture).of_type(:text)}
    it {is_expected.to have_db_column(:cv).of_type(:text)}
    it {is_expected.to have_db_column(:code).of_type(:string)}
  end

  context "validates" do
    it {is_expected.to validate_presence_of(:name)}
    it {is_expected.to validate_presence_of(:code)}
    it {is_expected.to validate_presence_of(:cv)}
    it {is_expected.to validate_presence_of(:phone)}
  end

  context "when name is not valid" do
    before {subject.name = ""}
    it "matches the error message" do
      subject.valid?
      subject.errors[:name].should include("can't be blank")
    end
  end

  context "when email is already exist" do
    before {subject.email = user1.email}
    it "matches the error message" do
      subject.valid?
      subject.errors[:email].should include("already exist")
    end
  end

  context "when email is not matches regex" do
    before {subject.email = "vts"}
    it "matches the error message" do
      expect(subject.email).not_to match(/\A[^@\s]+@[^@\s]+\z/)
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
    before {subject.password = Faker::Lorem.characters(200)}
    it "matches the error message" do
      subject.valid?
      subject.errors[:password].should include("is too long (maximum is 128 characters)")
    end
  end

  context "birthday cannot be in the future" do
    before {subject.birthday = 1.year.from_now}
    it "matches the error message" do
      subject.valid?
      subject.errors[:birthday].should include(I18n.t("users.form.birthday.validate"))
    end
  end

  context "when code is duplicate" do
    before {subject.code = user1.code}
    it "matches the error message" do
      subject.valid?
      subject.errors[:code].should include("has already been taken")
    end
  end

  context "when cv is not valid" do
    before {subject.cv = ""}
    it "matches the error message" do
      subject.valid?
      subject.errors[:cv].should include("can't be blank")
    end
  end

  context "when phone is not valid" do
    before {subject.phone = ""}
    it "matches the error message" do
      subject.valid?
      subject.errors[:phone].should include("can't be blank")
    end
  end

  context "when phone is too long" do
    before {subject.phone = Faker::Number.number(14)}
    it "matches the error message" do
      subject.valid?
      subject.errors[:phone].should include("is too long (maximum is 13 characters)")
    end
  end
end
