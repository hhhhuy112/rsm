require "rails_helper"

RSpec.describe BookmarkLike, type: :model do

  context "associations" do
    it {is_expected.to belong_to :user}
    it {is_expected.to belong_to :job}
  end

  context "columns" do
    it {is_expected.to have_db_column(:bookmark).of_type(:integer)}
    it {is_expected.to have_db_column(:user_id).of_type(:integer)}
    it {is_expected.to have_db_column(:job_id).of_type(:integer)}
  end
end
