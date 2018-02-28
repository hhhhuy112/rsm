require "rails_helper"

RSpec.describe Micropost, type: :model do
  context "associations" do
    it {is_expected.to belong_to :user}
  end
  
  context "column" do
    it {is_expected.to have_db_column(:content).of_type(:text)}
    it {is_expected.to have_db_column(:picture).of_type(:string)}
    it {is_expected.to have_db_column(:user_id).of_type(:integer)}
  end
end
