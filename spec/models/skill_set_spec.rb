require "rails_helper"

RSpec.describe SkillSet, type: :model do
  context "associations" do
    it {is_expected.to belong_to :skill}
    it {is_expected.to belong_to :interview_type}
  end
end
