require "rails_helper"

RSpec.describe Notification, type: :model do
  context "associations" do
    it {is_expected.to belong_to :user}
  end

  context "column" do
    it {is_expected.to have_db_column(:content).of_type(:text)}
    it {is_expected.to have_db_column(:status).of_type(:boolean)}
    it {is_expected.to have_db_column(:user_read).of_type(:integer)}
    it {is_expected.to have_db_column(:url_id).of_type(:integer)}
    it {is_expected.to have_db_column(:user_id).of_type(:integer)}
  end
end
