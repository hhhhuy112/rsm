require "rails_helper"

RSpec.describe Branch, type: :model do
  context "associations" do
    it {is_expected.to belong_to :company}
  end

  context "column" do
    it {is_expected.to have_db_column(:company_id).of_type(:integer)}
    it {is_expected.to have_db_column(:street).of_type(:string)}
    it {is_expected.to have_db_column(:ward).of_type(:string)}
    it {is_expected.to have_db_column(:district).of_type(:string)}
    it {is_expected.to have_db_column(:province).of_type(:string)}
    it {is_expected.to have_db_column(:country).of_type(:string)}
  end
end
