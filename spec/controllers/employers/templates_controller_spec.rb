require "rails_helper"

RSpec.describe Employers::TemplatesController, type: :controller do
  let(:user) {FactoryGirl.create :user, confirmed_at: Time.current}
  let(:company) {FactoryGirl.create :company}
  let!(:member) {FactoryGirl.create :member, company_id: company.id, user_id: user.id}
  let(:template) {FactoryGirl.create :template}
  subject {template}
  before {sign_in user}

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
      expect(assigns[:message]).to eq I18n.t("employers.template.create_success")
    end

    it "create template fail" do
      post :create, params: {template: {name: "phamd1ucpho", type_of: "template_user",
        template_body: "index.html", user_id: 11313}},
        xhr: true, format: "js"
    end
  end

  describe "GET #show" do
    before :each do
      get :show, format: :xhr, params: {id: subject.id}
    end

    it "assigns the requested user to @template" do
      expect(assigns(:template)) == template
    end
  end
end
