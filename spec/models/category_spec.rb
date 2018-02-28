require "rails_helper"

RSpec.describe Category, type: :model do
  context "associations" do
    it {is_expected.to belong_to :company}
  end

  context "column" do
    it {is_expected.to have_db_column(:company_id).of_type(:integer)}
    it {is_expected.to have_db_column(:name).of_type(:string)}
    it {is_expected.to have_db_column(:description).of_type(:text)}
  end
end
