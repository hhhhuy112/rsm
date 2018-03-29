require "rails_helper"

RSpec.describe Employers::CandidatesController, type: :controller do
  let(:company) {FactoryGirl.create :company}
  let(:user) {FactoryGirl.create :user, confirmed_at: Time.current, company_id: company.id}
  let(:branch) {FactoryGirl.create :branch, company_id: company.id}
  let(:category) {FactoryGirl.create :category, company_id: company.id}
  let(:step) {FactoryGirl.create :step}
  let!(:member) {FactoryGirl.create :member, company_id: company.id, user_id: user.id}
  let(:currency) {FactoryGirl.create :currency, company_id: company.id}
  let :job do
    FactoryGirl.create :job, company_id: company.id, branch_id: branch.id,
      category_id: category.id, currency_id: currency.id
  end
  let(:status_step) {FactoryGirl.create :status_step, step_id: step.id}
  let(:apply) do
    FactoryGirl.create :apply, user_id: user.id, job_id: job.id
  end
  let!(:apply_status) do
    FactoryGirl.create :apply_status, apply_id: apply.id, status_step_id: status_step.id
  end

  before do
    sign_in user
    request.host = "#{company.subdomain}.lvh.me:3000"
  end

  describe "GET #index" do
    context "index success" do
      before :each do
        get :index, params: {company_id: company.id}
      end

      it "assigns the requested job to @job" do
        expect(assigns(:candidates)).to be_truthy
      end

      it "renders the #index view" do
        expect(response).to render_template "employers/candidates/index"
      end
    end
  end

  describe "GET #show" do
    context "show success" do
      before :each do
        get :show, params: {company_id: company.id, id: user.id}
      end

      it "assigns the requested job to @job" do
        expect(assigns(:candidate)).to be_truthy
      end

      it "renders the #show view" do
        expect(response).to render_template "employers/candidates/show"
      end
    end

    context "show fail" do
      before :each do
        get :show, params: {company_id: company.id, id: 2000}
      end

      it "not found apply_status" do
        expect(response).to redirect_to root_url
      end
    end
  end

  describe "GET #new" do
    context "new success" do
      before :each do
        get :new, xhr: true, params: {company_id: company.id, id: user.id}
      end

      it "assigns the requested candidate to @candiate" do
        expect(assigns(:candidate)).to be_truthy
      end

      it "renders the #new view" do
        expect(response).to render_template "employers/candidates/new"
      end
    end

    context "new fail" do
      before :each do
        get :new, xhr: true, params: {company_id: company.id, id: 10}
      end

      it "not found apply_status" do
        expect(response).to render_template "errors/error"
      end
    end
  end

  describe "POST #create" do
    context "create fail" do
      before :each do
        post :create, xhr: true, params: {company_id: company.id, apply: {information: {name: "Lam Phan",
          email: "dinhlam1@gmail.com", phone: "01224558567"},
          cv: File.new(File.expand_path(Rails.root.join("lib", "seeds", "template_cv.pdf")))}}
      end

      it "assigns the requested error" do
        expect(assigns(:apply).errors).to be_truthy
      end

      it "renders the #create view" do
        expect(response).to render_template "employers/candidates/create"
      end
    end
  end
end
