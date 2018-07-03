require "rails_helper"

RSpec.describe Evaluation, type: :model do
  context "associations" do
    it {is_expected.to belong_to :apply}
    it {is_expected.to have_many :knowledges}
  end
end
