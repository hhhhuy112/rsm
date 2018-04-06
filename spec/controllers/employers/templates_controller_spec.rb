require "rails_helper"

RSpec.describe Employers::TemplatesController, type: :controller do
  let(:user) {FactoryGirl.create :user, confirmed_at: Time.current}
  let(:company) {FactoryGirl.create :company}
  let!(:member) {FactoryGirl.create :member, company_id: company.id, user_id: user.id}
  let(:template) {FactoryGirl.create :template, company_id: company.id}
  subject {template}
  before do
    sign_in user
    request.host = "#{company.subdomain}.lvh.me:3000"
  end

  describe "GET /employers/templates" do
    it "returns http success for an AJAX request" do
      {:get => "/employers/templates", format: :xhr}.should be_routable
    end
  end

  describe "GET /employers/templates/new" do
    it "returns http success for an AJAX request" do
      {:get => "/employers/templates/new", format: :xhr}.should be_routable
    end
  end

  describe "POST #create" do
    before {request.host = "#{company.subdomain}.lvh.me:3000"}
    it "create template success" do
      post :create, params: {template: {name: "phamd1ucpho", type_of: "template_member",
        template_body: "index.html",title: "admin", user_id: user.id}},
        xhr: true, format: "js"
      expect(assigns[:message]).to eq I18n.t("employers.templates.create_success")
      expect(assigns[:interviewers]).to be_truthy
      expect(assigns[:candidates]).to be_truthy
      expect(assigns[:benefits]).to be_truthy
      expect(assigns[:skills]).to be_truthy
    end

    it "create template fail" do
      post :create, params: {template: {name: "phamd1ucpho", type_of: "template_user",
        template_body: "index.html", user_id: 11313}},
        xhr: true, format: "js"
      expect(assigns[:template].errors.messages).to be_truthy
    end
  end

  describe "GET #show" do
    before :each do
      get :show, xhr: true, params: {id: subject.id}
    end

    it "assigns the requested user to @template" do
      expect(assigns(:template)).to eq subject
    end
  end

  describe "patch #update" do
    context "update success" do
      before :each do
        patch :update, xhr: true, params: {id: subject.id, template: {name: "template_benefit",
          type_of: "template_benefit", template_body: "index.html",
          title: "admin", user_id: user.id}}
      end

      it "update template succes with render" do
        expect(response).to render_template "update"
      end

      it "update template success with messae" do
        expect(assigns(:message)).to eq I18n.t("employers.templates.update")
      end

      it "update template success with reload templates" do
        expect(assigns[:interviewers]).to be_truthy
        expect(assigns[:candidates]).to be_truthy
        expect(assigns[:benefits]).to be_truthy
        expect(assigns[:skills]).to be_truthy
      end
    end

    context "update fail" do
      before :each do
        patch :update, xhr: true, params: {id: subject.id, template: {name: "template_benefit",
          type_of: "template_benefit", title: "admin", user_id: user.id}}
      end

      it "update template succes with RecordInvalid" do
        expect(assigns(:template).errors.messages).to be_truthy
      end
    end
  end

  describe "delete #destroy" do
    context "delete success" do
      before :each do
        delete :destroy, xhr: true, params: {id: subject.id}
      end

      it "update template succes with render" do
        expect(response).to render_template "destroy"
      end

      it "update template success with messae" do
        expect(assigns(:message)).to eq I18n.t("employers.templates.destroy")
      end

      it "delete template success with reload templates" do
        expect(assigns[:interviewers]).to be_truthy
        expect(assigns[:candidates]).to be_truthy
        expect(assigns[:benefits]).to be_truthy
        expect(assigns[:skills]).to be_truthy
      end
    end
  end
end
