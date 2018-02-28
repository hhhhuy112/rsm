require "rails_helper"

RSpec.describe Company, type: :model do

  context "associations" do
    it {is_expected.to have_many :appointments}
    it {is_expected.to have_many :projects}
    it {is_expected.to have_many :jobs}
    it {is_expected.to have_many :members}
    it {is_expected.to have_many :passive_report}
    it {is_expected.to have_many :passive_follow}
  end

  context "columns" do
    it {is_expected.to have_db_column(:name).of_type(:string)}
    it {is_expected.to have_db_column(:address).of_type(:text)}
    it {is_expected.to have_db_column(:phone).of_type(:string)}
    it {is_expected.to have_db_column(:majors).of_type(:string)}
  end
end
