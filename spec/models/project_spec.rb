require "rails_helper"

RSpec.describe Project, type: :model do
  context "associations" do
    it {is_expected.to have_many(:project_members).dependent :destroy}
    it {is_expected.to belong_to :company}
  end

  context "columns" do
    it {is_expected.to have_db_column(:name).of_type :string}
    it {is_expected.to have_db_column(:info).of_type :text}
    it {is_expected.to have_db_column(:company_id).of_type :integer}
  end
end
