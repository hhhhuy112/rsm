require "rails_helper"

RSpec.describe Template, type: :model do
   context "associations" do
    it {is_expected.to belong_to :user}
  end

   context "columns" do
    it {is_expected.to have_db_column(:name).of_type(:string)}
    it {is_expected.to have_db_column(:type_of).of_type(:integer)}
    it {is_expected.to have_db_column(:user_id).of_type(:integer)}
    it {is_expected.to have_db_column(:template_body).of_type(:text)}
  end
end
