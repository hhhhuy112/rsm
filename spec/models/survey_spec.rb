require "rails_helper"

RSpec.describe Survey, type: :model do
  context "associations" do
    it {is_expected.to belong_to :question}
    it {is_expected.to belong_to :job}
    it {is_expected.to have_many(:answers).dependent :destroy}
  end
end
