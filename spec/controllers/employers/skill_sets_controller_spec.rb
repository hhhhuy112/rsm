require "rails_helper"

RSpec.describe Employers::SkillSetsController, type: :controller do
  let(:company) {FactoryGirl.create :company}
  let(:employer) {FactoryGirl.create :user, role: "employer",
    confirmed_at: Time.current, company_id: company.id}
  let(:interview_type) {FactoryGirl.create :interview_type, company_id: company.id}
  let(:skill) {FactoryGirl.create :skill, company_id: company.id}
  let(:skill_set) {FactoryGirl.create :skill_set, interview_type_id: interview_type.id, skill_id: skill.id}

  subject {skill_set}

  before{
    sign_in employer
    allow(controller).to receive(:check_permissions_employer).and_return(true)
    allow(controller).to receive(:current_ability).and_return(true)
    allow(controller).to receive(:load_notifications).and_return(true)
    allow(controller).to receive(:authorize!).and_return(true)
    request.host = "#{company.subdomain}.lvh.me:3000"
  }

  describe "GET /employers/skill_sets/new" do
    it "returns http success for an AJAX request" do
      {:get => "/employers/skill_sets/new", format: :xhr}.should be_routable
    end
  end

  describe "DELETE #destroy" do
    it "destroy skill_set success" do
      delete :destroy, params: {id: subject.id}, xhr: true, format: :js
      expect(assigns[:success]).to match I18n.t("employers.interview_types.destroy_success")
    end
  end
end
