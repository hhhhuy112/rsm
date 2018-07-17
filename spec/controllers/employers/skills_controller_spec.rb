require "rails_helper"

RSpec.describe Employers::SkillsController, type: :controller do
  let(:company) {FactoryGirl.create :company}
  let(:employer) {FactoryGirl.create :user, role: "employer",
    confirmed_at: Time.current, company_id: company.id}
  let(:skill) {FactoryGirl.create :skill, company_id: company.id}

  subject {skill}

  before{
    sign_in employer
    allow(controller).to receive(:check_permissions_employer).and_return(true)
    allow(controller).to receive(:current_ability).and_return(true)
    allow(controller).to receive(:load_notifications).and_return(true)
    allow(controller).to receive(:authorize!).and_return(true)
    request.host = "#{company.subdomain}.lvh.me:3000"
  }

  describe "GET #index" do
    context "index skills" do
      before :each do
        allow_any_instance_of(CanCan::ControllerResource).to receive(:load_and_authorize_resource){nil}
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

  describe "GET /employers/skills/edit" do
    it "returns http success for an AJAX request" do
      {:get => "/employers/skills/edit", format: :xhr}.should be_routable
    end
  end

  describe "PATCH #update" do
    context "update success" do
      it "update with name" do
        patch :update, params: {id: subject.id, skill:{name: Faker::Name.name,
          type_skill: Settings.skills.type.basic}}, format: :js
        expect(assigns(:success)).to eq I18n.t("employers.skills.updated_success")
      end
    end

    context "update fail" do
      it "update with name" do
        patch :update, params: {id: subject.id, skill:{name: "", type_skill: Settings.skills.type.basic}}, format: :js
        expect(assigns[:skill].errors).to be_present
      end
    end
  end

  describe "DELETE #destroy" do
    context "destroy success" do
      before :each do
        delete :destroy, params: {id: subject.id}, xhr: true, format: :js
      end

      it "assigns the requested success to @success" do
        expect(assigns[:success]).to match I18n.t("employers.skills.deleted_success")
      end

      it "assigns the requested skills to @basic_skills" do
        expect(assigns(:basic_skills)).to be_truthy
      end

      it "assigns the requested skills to @writing_skills" do
        expect(assigns(:writing_skills)).to be_truthy
      end
    end
  end
end
