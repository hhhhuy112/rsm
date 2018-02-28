require "rails_helper"

RSpec.describe ProjectMember, type: :model do
  context "associations" do
    it {is_expected.to belong_to :member}
    it {is_expected.to belong_to :project}
  end

  context "column" do
    it {is_expected.to have_db_column(:status).of_type(:boolean)}
    it {is_expected.to have_db_column(:member_id).of_type(:integer)}
    it {is_expected.to have_db_column(:project_id).of_type(:integer)}
  end
end
