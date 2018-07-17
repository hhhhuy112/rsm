require "rails_helper"

RSpec.describe Employers::InterviewTypesController, type: :controller do
  let(:company) {FactoryGirl.create :company}
  let(:employer) {FactoryGirl.create :user, role: "employer",
    confirmed_at: Time.current, company_id: company.id}
  let(:interview_type) {FactoryGirl.create :interview_type, company_id: company.id}

  subject {interview_type}
  before{
    sign_in employer
    allow(controller).to receive(:check_permissions_employer).and_return(true)
    allow(controller).to receive(:current_ability).and_return(true)
    allow(controller).to receive(:load_notifications).and_return(true)
    allow(controller).to receive(:authorize!).and_return(true)
    request.host = "#{company.subdomain}.lvh.me:3000"
  }

  describe "GET #index" do
    context "index interview_types" do
      before :each do
        allow_any_instance_of(CanCan::ControllerResource).to receive(:load_and_authorize_resource){}
        get :index
      end

      it "assigns the requested interview_types to @interview_types" do
        expect(assigns(:interview_types)).to be_truthy
      end

      it "renders the #index view" do
        expect(response).to render_template "employers/interview_types/index"
      end
    end
  end

  describe "GET /employers/interview_types/new" do
    it "returns http success for an AJAX request" do
      {:get => "/employers/interview_types/new", format: :xhr}.should be_routable
    end
  end

  describe "GET /employers/interview_types/edit" do
    it "returns http success for an AJAX request" do
      {:get => "/employers/interview_types/edit", format: :xhr}.should be_routable
    end
  end

  describe "PATCH #update" do
    context "update success" do
      it "update with name" do
        patch :update, params: {id: subject.id, interview_type:{name: Faker::Name.name}}, format: :js
        expect(assigns(:success)).to eq I18n.t("employers.interview_types.update_success")
      end
    end

    context "update fail" do
      it "update with name" do
        patch :update, params: {id: subject.id, interview_type:{name: ""}}, format: :js
        expect(assigns[:interview_type].errors).to be_present
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroy interview_type success" do
      delete :destroy, params: {id: subject.id}, xhr: true, format: :js
      expect(assigns[:success]).to match I18n.t("employers.interview_types.destroy_success")
    end
  end
end
