require "rails_helper"

RSpec.describe Employers::EvaluationsController, type: :controller do
  let(:company) {FactoryGirl.create :company}
  let(:employer) {FactoryGirl.create :user, role: "employer", company_id: company.id,
    confirmed_at: Time.current}

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
    context "index evaluations" do
      before :each do
        get :index
      end

      it "assigns the requested activities to @activities" do
        expect(assigns(:activities)).to be_truthy
      end

      it "assigns the requested applies_status to @applies_status" do
        expect(assigns(:applies_status)).to be_truthy
      end

      it "renders the #index view" do
        expect(response).to render_template "employers/evaluations/index"
      end
    end
  end
end
