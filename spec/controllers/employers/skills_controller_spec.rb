require "rails_helper"

RSpec.describe Employers::SkillsController, type: :controller do
  let(:company) {FactoryGirl.create :company}
  let(:employer) {FactoryGirl.create :user, role: "employer",
    confirmed_at: Time.current, company_id: company.id}
  let(:skill) {FactoryGirl.create :skill, company_id: company.id}

  before{
    sign_in employer
    request.host = "#{company.subdomain}.lvh.me:3000"
  }
end
