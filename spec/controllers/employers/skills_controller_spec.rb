require "rails_helper"

RSpec.describe Employers::SkillsController, type: :controller do
  let(:company) {FactoryGirl.create :company}
  let(:employer) {FactoryGirl.create :user, role: "employer",
    confirmed_at: Time.current, company_id: company.id}
  let(:skill) {FactoryGirl.create :skill, company_id: company.id}

  before{
    sign_in employer
    allow(controller).to receive(:check_permissions_employer).and_return(true)
    allow(controller).to receive(:current_ability).and_return(true)
    allow(controller).to receive(:load_notifications).and_return(true)
    allow(controller).to receive(:authorize!).and_return(true)
    allow_any_instance_of(CanCan::ControllerResource).to receive(:load_and_authorize_resource){nil}
    request.host = "#{company.subdomain}.lvh.me:3000"
  }

  describe "GET #index" do
    context "index skills" do
      before :each do
        get :index
      end

      it "assigns the requested skills to @basic_skills" do
        expect(assigns(:basic_skills)).to be_truthy
      end

      it "assigns the requested skills to @writing_skills" do
        expect(assigns(:writing_skills)).to be_truthy
      end

      it "renders the #index view" do
        expect(response).to render_template "employers/skills/index"
      end
    end
  end

  describe "GET /employers/skills/new" do
    it "returns http success for an AJAX request" do
      {:get => "/employers/skills/new", format: :xhr}.should be_routable
    end
  end
end
