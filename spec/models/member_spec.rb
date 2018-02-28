require "rails_helper"

RSpec.describe Member, type: :model do
  context "associations" do
    it {is_expected.to have_many :project_members}
    it {is_expected.to belong_to :company}
    it {is_expected.to belong_to :user}
  end

  context "column" do
    it {is_expected.to have_db_column(:position).of_type(:string)}
    it {is_expected.to have_db_column(:start_time).of_type(:date)}
    it {is_expected.to have_db_column(:end_time).of_type(:date)}
    it {is_expected.to have_db_column(:company_id).of_type(:integer)}
    it {is_expected.to have_db_column(:user_id).of_type(:integer)}
  end
end
