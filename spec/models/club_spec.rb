require "rails_helper"

RSpec.describe Club, type: :model do
  let(:company){FactoryGirl.create :company}
  let(:user) {FactoryGirl.create :user, company_id: company.id}
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
    it {is_expected.to validate_presence_of(:name)
      .with_message(I18n.t("activerecord.errors.models.club.attributes.name.blank"))}
    it {is_expected.to validate_length_of(:name).is_at_most(Settings.clubs.model.name_max_length)
      .with_message(I18n.t("activerecord.errors.models.club.attributes.name.too_long"))}
    it {is_expected.to validate_presence_of(:position)
      .with_message(I18n.t("activerecord.errors.models.club.attributes.position.blank"))}
    it {is_expected.to validate_length_of(:position).is_at_most(Settings.clubs.model.pos_max_length)
      .with_message(I18n.t("activerecord.errors.models.club.attributes.position.too_long"))}
    it {is_expected.to validate_presence_of(:start_time)
      .with_message(I18n.t("activerecord.errors.models.club.attributes.start_time.blank"))}

    context "unless current" do
      before {allow(club).to receive(:current?).and_return(false)}
      it {is_expected.to validate_presence_of(:end_time)
        .with_message(I18n.t("activerecord.errors.models.club.attributes.end_time.blank"))}

      context "end_date_after_start_date" do
        before {@club = Club.create(name: Faker::Name.name, user_id: user.id, start_time: Time.zone.today-1, end_time:Time.zone.today) }
        it {@club.end_time.should > @club.start_time}
      end
    end

    context "if content" do
      before {allow(club).to receive(:content?).and_return(true)}
      it {is_expected.to validate_length_of(:content).is_at_least(Settings.clubs.model.cont_min_length)
        .with_message(I18n.t("activerecord.errors.models.club.attributes.content.too_short"))}
      it {is_expected.to validate_length_of(:content).is_at_most(Settings.clubs.model.cont_max_length)
        .with_message(I18n.t("activerecord.errors.models.club.attributes.content.too_long"))}
    end

    context "date less than today" do
      before {@club = Club.create(name: Faker::Name.name, user_id: user.id, start_time: Time.zone.today-1, end_time:Time.zone.today)}
      it {@club.start_time.should  <= Time.zone.today}
      it {@club.end_time.should  <= Time.zone.today}
    end
  end
end
