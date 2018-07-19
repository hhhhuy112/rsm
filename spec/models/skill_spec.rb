require "rails_helper"

RSpec.describe Skill, type: :model do
  context "associations" do
    it {is_expected.to belong_to :company}
    it {is_expected.to have_many :knowledges}
    it {is_expected.to have_many :skill_sets}
  end

  context "validates" do
    it {is_expected.to validate_presence_of(:name)
      .with_message(I18n.t("activerecord.errors.models.skill.attributes.name.blank"))}
  end
end
