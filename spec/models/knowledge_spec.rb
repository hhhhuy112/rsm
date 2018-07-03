require "rails_helper"

RSpec.describe Knowledge, type: :model do
  context "associations" do
    it {is_expected.to belong_to :evaluation}
    it {is_expected.to belong_to :skill}
  end
end
