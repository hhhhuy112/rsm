require "rails_helper"

RSpec.describe Template, type: :model do
  context "associations" do
    it {is_expected.to belong_to :user}
    it {is_expected.to belong_to :company}
  end

  context "columns" do
    it {is_expected.to have_db_column(:name).of_type(:string)}
    it {is_expected.to have_db_column(:type_of).of_type(:integer)}
    it {is_expected.to have_db_column(:user_id).of_type(:integer)}
    it {is_expected.to have_db_column(:company_id).of_type(:integer)}
    it {is_expected.to have_db_column(:template_body).of_type(:text)}
  end

  context "validates" do
    it {is_expected.to validate_presence_of(:name)
      .with_message(I18n.t("activerecord.errors.models.template.attributes.name.blank"))}
    it {is_expected.to validate_uniqueness_of(:name).scoped_to(:company_id)}
    it {is_expected.to validate_presence_of(:title)
      .with_message(I18n.t("activerecord.errors.models.template.attributes.title.blank"))}
    it {is_expected.to validate_presence_of(:type_of)
      .with_message(I18n.t("activerecord.errors.models.template.attributes.type_of.blank"))}
    it {is_expected.to define_enum_for(:type_of)
      .with(%i(template_member template_user template_benefit template_skill))}
    it {is_expected.to validate_presence_of(:template_body)
      .with_message(I18n.t("activerecord.errors.models.template.attributes.template_body.blank"))}
  end
end
