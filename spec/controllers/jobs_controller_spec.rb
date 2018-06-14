require "rails_helper"

RSpec.describe JobsController, type: :controller do
  let(:company) {FactoryGirl.create :company}
  let(:question) {FactoryGirl.create :question, company_id: company.id}
  let(:currency) {FactoryGirl.create :currency, company_id: company.id}
  let(:branch) {FactoryGirl.create :branch, company_id: company.id}
  let(:category) {FactoryGirl.create :category, company_id: company.id}
  let(:user) {FactoryGirl.create :user, confirmed_at: Time.current, company_id: company.id}
  let(:job) {FactoryGirl.create :job, company_id: company.id, user_id: user.id,
    branch_id: branch.id, category_id: category.id,currency_id: currency.id}
  let(:survey) {FactoryGirl.create :survey, job_id: job.id, question_id: question.id}
  subject {job}
  before {
    sign_in user
    request.host = "#{company.subdomain}.lvh.me:3000"
  }

  describe "GET #index" do
    it "render the index template" do
      get :index
      expect(response).to render_template :index
    end
  end

  describe "POST #create" do
    it "create job fail" do
      post :create, params: {job: {content: "content", branch_id: branch.id,
        user_id: user.id}}, xhr: true, format: "js"
      expect(assigns[:job].errors).to be_present
    end
  end

  describe "PATCH #update" do
    it "update job fail" do
      patch :update, params: {id: subject.id, job: {content: "content"}},xhr: true, format: "js"
    end
  end

  describe "DELETE #destroy" do
    it "destroy job success" do
      delete :destroy, params: {id: subject.id}, xhr: true, format: "js"
      expect(flash.now[:success]).to match I18n.t("jobs.destroy.job_destroyed")
    end
  end
end
