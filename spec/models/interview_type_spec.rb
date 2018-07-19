require "rails_helper"

RSpec.describe InterviewType, type: :model do
  context "associations" do
    it {is_expected.to belong_to :company}
    it {is_expected.to have_many :skill_sets}
  end
end
