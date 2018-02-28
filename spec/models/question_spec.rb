require "rails_helper"

RSpec.describe Question, type: :model do
  context "associations" do
    it {is_expected.to belong_to :company}
  end

  context "validates" do
    it {is_expected.to validate_presence_of :name}
  end

  context "columns" do
    it {is_expected.to have_db_column(:company_id).of_type :integer}
    it {is_expected.to have_db_column(:name).of_type :text}
  end
end
