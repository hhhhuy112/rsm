require "rails_helper"

RSpec.describe User, type: :model do

  let(:company){FactoryGirl.create :company}
  let(:user){FactoryGirl.create :user, name: Faker::Name.name, email: Faker::Internet.email,
    company_id: company.id, code: Faker::Lorem.characters(10), phone: Faker::Number.number(10)}

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
    it {is_expected.to validate_presence_of(:name)
      .with_message(I18n.t("activerecord.errors.models.user.attributes.name.blank"))}
    it {is_expected.to validate_uniqueness_of(:email).case_insensitive.scoped_to(:company_id)
      .with_message(I18n.t("users.form.empty"))}
    it {is_expected.to validate_presence_of(:code)
      .with_message(I18n.t("activerecord.errors.models.user.attributes.code.blank"))}
    it {is_expected.to validate_presence_of(:cv)
      .with_message(I18n.t("activerecord.errors.models.user.attributes.cv.blank"))}
    it {is_expected.to validate_presence_of(:phone)
      .with_message(I18n.t("activerecord.errors.models.user.attributes.phone.blank"))}
    it {is_expected.to validate_length_of(:phone).is_at_most(Settings.phone_max_length)
      .with_message(I18n.t("activerecord.errors.models.user.attributes.phone.too_long"))}
    it {is_expected.to define_enum_for(:sex).with(%i(female male))}
    it {is_expected.to define_enum_for(:role).with(%i(user employer admin))}
  end
end
