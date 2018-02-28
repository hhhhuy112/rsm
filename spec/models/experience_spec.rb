require "rails_helper"

RSpec.describe Experience, type: :model do
  let(:user) {FactoryGirl.create :user}
  let(:experience) {FactoryGirl.create :experience, user_id: user.id}

  subject {experience}

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
    it {is_expected.to validate_presence_of(:name)}
    it {is_expected.to validate_length_of(:name).is_at_most(150)}
    it {is_expected.to validate_presence_of(:user_id)}
    it {is_expected.to validate_presence_of(:company)}
    it {is_expected.to validate_length_of(:company).is_at_most(150)}

    context "start date is exists" do
      before {allow(experience).to receive(:start_time?).and_return(true)}

      it {is_expected.to validate_presence_of(:end_time)}
      context "end_date_after_start_date" do
        before {@exp = Experience.create(name: "Name", company: "Company", user_id: user.id,
          start_time: Time.zone.today - 1, end_time:Time.zone.today)}
        it {@exp.end_time.should > @exp.start_time}
      end
    end

    context "project details is present" do
      before {allow(experience).to receive(:project_detail?).and_return(true)}

      it {is_expected.to validate_length_of(:project_detail).is_at_least(20)}
      it {is_expected.to validate_length_of(:project_detail).is_at_most(5000)}
    end

    context "date less than today" do
      before :each do
        @exp = Experience.create(name: "Name", company: "Company", user_id: user.id,
          start_time: Time.zone.today - 1, end_time:Time.zone.today)
      end

      it {@exp.start_time.should <= Time.zone.today}
      it {@exp.end_time.should <= Time.zone.today}
    end
  end

  context "name is blank" do
    before {subject.name = ""}

    it "matches the errors message" do
      subject.valid?
      subject.errors[:name].should include(
        I18n.t("activerecord.errors.models.experience.attributes.name.blank"))
    end
    it {is_expected.to_not be_valid}
  end

  context "name is more than 150 character" do
    before {subject.name = Faker::Lorem.characters(151)}

    it "matches the errors message" do
      subject.valid?
      subject.errors[:name].should include(
        I18n.t("activerecord.errors.models.experience.attributes.name.too_long"))
    end
    it {is_expected.to_not be_valid}
  end

  context "company is more than 150 character" do
    before {subject.company = Faker::Lorem.characters(151)}

    it "matches the errors message" do
      subject.valid?
      subject.errors[:company].should include(
        I18n.t("activerecord.errors.models.experience.attributes.company.too_long"))
    end
    it {is_expected.to_not be_valid}
  end

  context "company is blank" do
    before {subject.company = ""}

    it "matches the errors message" do
      subject.valid?
      subject.errors[:company].should include(
        I18n.t("activerecord.errors.models.experience.attributes.company.blank"))
    end
    it {is_expected.to_not be_valid}
  end

  context "end time is blank with start time exists" do
    before {subject.end_time = ""}

    it "matches the errors message" do
      subject.valid?
      subject.errors[:end_time].should include(
        I18n.t("activerecord.errors.models.experience.attributes.end_time.blank"))
    end
    it {is_expected.to_not be_valid}
  end

  context "project details is more than 5000 character" do
    before {subject.project_detail = Faker::Lorem.characters(5001)}

    it "matches the errors message" do
      subject.valid?
      subject.errors[:project_detail].should include(
        I18n.t("activerecord.errors.models.experience.attributes.project_detail.too_long"))
    end
    it {is_expected.to_not be_valid}
  end

  context "project details is less than 20 character" do
    before {subject.project_detail = Faker::Lorem.characters(19)}

    it "matches the errors message" do
      subject.valid?
      subject.errors[:project_detail].should include(
        I18n.t("activerecord.errors.models.experience.attributes.project_detail.too_short"))
    end
    it {is_expected.to_not be_valid}
  end
end
