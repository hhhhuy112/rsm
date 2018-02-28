require "rails_helper"

RSpec.describe Club, type: :model do
  let(:user) {FactoryGirl.create :user}
  let(:club) {FactoryGirl.create :club, user_id: user.id}
  subject {club}

  context "associations" do
    it {is_expected.to belong_to :user}
  end

  context "columns" do
    it {is_expected.to have_db_column(:name).of_type(:string)}
    it {is_expected.to have_db_column(:user_id).of_type(:integer)}
    it {is_expected.to have_db_column(:start_time).of_type(:date)}
    it {is_expected.to have_db_column(:end_time).of_type(:date)}
    it {is_expected.to have_db_column(:content).of_type(:text)}
    it {is_expected.to have_db_column(:current).of_type(:boolean)}
  end

  context "validates" do
    it {is_expected.to validate_presence_of(:name)}
    it {is_expected.to validate_length_of(:name).is_at_most(150)}
    it {is_expected.to validate_presence_of(:position)}
    it {is_expected.to validate_length_of(:position).is_at_most(100)}
    it {is_expected.to validate_presence_of(:start_time)}
    context "unless current" do
      before { allow(club).to receive(:current?).and_return(false) }
      it {is_expected.to validate_presence_of(:end_time)}
      context "end_date_after_start_date" do
        before { @club = Club.create(name: "ABCX", user_id: User.new, start_time: Time.zone.today-1, end_time:Time.zone.today) }
        it { @club.end_time.should > @club.start_time}
      end
    end

    context "if content" do
      before { allow(club).to receive(:content?).and_return(true) }
      it {is_expected.to validate_length_of(:content).is_at_least(20)}
      it {is_expected.to validate_length_of(:content).is_at_most(5000)}
    end

    context "date less than today" do
      before { @club = Club.create(name: "ABCX", user_id: User.new, start_time: Time.zone.today-1, end_time:Time.zone.today) }
      it { @club.start_time.should  <= Time.zone.today}
      it { @club.end_time.should  <= Time.zone.today}
    end
  end

  context "name is blank" do
    before {subject.name = ""}
    it "matches the errors message" do
      subject.valid?
      subject.errors[:name].should include(I18n.t("activerecord.errors.models.club.attributes.name.blank"))
    end
    it {is_expected.to_not be_valid}
  end

  context "position is blank" do
    before {subject.position = ""}
    it "matches the errors message" do
      subject.valid?
      subject.errors[:position].should include(I18n.t("activerecord.errors.models.club.attributes.position.blank"))
    end
    it {is_expected.to_not be_valid}
  end

  context "start time is blank" do
    before { @club = Club.create(name: "ABCX", user_id: User.new, start_time: "", end_time:Time.zone.today) }
    it "matches the errors message" do
      @club.valid?
      @club.errors[:start_time].should include(I18n.t("activerecord.errors.models.club.attributes.start_time.blank"))
    end
    it {expect(@club).to_not be_valid}
  end

  context "end time is blank" do
    before { @club = Club.create(name: "ABCX", user_id: User.new, start_time: Time.zone.today-1, end_time:"", current: false) }
    it "matches the errors message" do
      @club.valid?
      @club.errors[:end_time].should include(I18n.t("activerecord.errors.models.club.attributes.end_time.blank"))
    end
    it {expect(@club).to_not be_valid}
  end
end
