require "rails_helper"

RSpec.describe Template, type: :model do

  let(:company){FactoryGirl.create :company}
  let(:user){FactoryGirl.create :user, email: Faker::Internet.email, company_id: company.id,
    cv: Rails.root.join("public/uploads/user/cv/1/abc.pdf").open}
  let(:template){FactoryGirl.create :template, name: Faker::Name.name,
    title: Faker::Name.name, type_of: 1, template_body: Faker::Lorem.paragraph,
    user_id: user.id, company_id: company.id}

  subject{template}

  context "associations" do
    it {is_expected.to belong_to :user}
    it {is_expected.to belong_to :company}
  end

  context "columns" do
    it {is_expected.to have_db_column(:name).of_type(:string)}
    it {is_expected.to have_db_column(:type_of).of_type(:integer)}
    it {is_expected.to have_db_column(:user_id).of_type(:integer)}
    it {is_expected.to have_db_column(:company_id).of_type(:integer)}
    it {is_expected.to have_db_column(:template_body).of_type(:text)}
  end

  context "validates" do
    it {is_expected.to validate_presence_of(:name)}
    it {is_expected.to validate_uniqueness_of(:name).scoped_to(:company_id)}
    it {is_expected.to validate_presence_of(:title)}
    it {is_expected.to validate_presence_of(:type_of)}
    it {is_expected.to define_enum_for(:type_of)
      .with(%w(template_member template_user template_benefit template_skill))}
    it {is_expected.to validate_presence_of(:template_body)}
  end

  context "when name is not valid" do
    before {subject.name = ""}
    it "matches the error message" do
      subject.valid?
      subject.errors[:name].should include("can't be blank")
    end
  end

  context "when title is not valid" do
    before {subject.title = ""}
    it "matches the error message" do
      subject.valid?
      subject.errors[:title].should include("can't be blank")
    end
  end

  context "when type_of is not valid" do
    before {subject.type_of = nil}
    it "matches the error message" do
      subject.valid?
      subject.errors[:type_of].should include("can't be blank")
    end
  end

  context "when template_body is not valid" do
    before {subject.template_body = ""}
    it "matches the error message" do
      subject.valid?
      subject.errors[:template_body].should include("can't be blank")
    end
  end
end
