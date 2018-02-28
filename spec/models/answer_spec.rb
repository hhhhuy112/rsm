require "rails_helper"

RSpec.describe Answer, type: :model do
  context "associations" do
    it {is_expected.to belong_to :apply}
    it {is_expected.to belong_to :survey}
  end

  context "columns" do
    it {is_expected.to have_db_column(:apply_id).of_type :integer}
    it {is_expected.to have_db_column(:survey_id).of_type :integer}
    it {is_expected.to have_db_column(:name).of_type :text}
  end
end
