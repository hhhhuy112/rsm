require "rails_helper"

RSpec.describe Apply, type: :model do
  context "associations" do
    it {is_expected.to belong_to :user}
    it {is_expected.to belong_to :job}
    it {is_expected.to have_one :company}
  end

   context "columns" do
    it {is_expected.to have_db_column(:status).of_type(:integer)}
    it {is_expected.to have_db_column(:user_id).of_type(:integer)}
    it {is_expected.to have_db_column(:job_id).of_type(:integer)}
    it {is_expected.to have_db_column(:cv).of_type(:text)}
    it {is_expected.to have_db_column(:information).of_type(:text)}
  end
end
