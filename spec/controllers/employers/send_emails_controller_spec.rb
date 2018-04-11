require "rails_helper"

RSpec.describe Employers::SendEmailsController, type: :controller do
  let(:company) {FactoryGirl.create :company}
  let(:user) {FactoryGirl.create :user, confirmed_at: Time.current, company_id: company.id}
  let!(:member) {FactoryGirl.create :member, company_id: company.id, user_id: user.id}
  let(:branch) {FactoryGirl.create :branch, company_id: company.id}
  let(:category) {FactoryGirl.create :category, company_id: company.id}
  let(:step) {FactoryGirl.create :step}
  let(:currency) {FactoryGirl.create :currency, company_id: company.id}
  let :job do
    FactoryGirl.create :job, company_id: company.id, branch_id: branch.id,
      category_id: category.id, currency_id: currency.id
  end
  let(:status_step) {FactoryGirl.create :status_step, step_id: step.id}
  let(:apply) do
    FactoryGirl.create :apply, user_id: user.id, job_id: job.id
  end
  let(:apply_status) do
    FactoryGirl.create :apply_status, apply_id: apply.id, status_step_id: status_step.id
  end
  let!(:oauth) {FactoryGirl.create :oauth, user_id: user.id}
  let!(:email_sent) {FactoryGirl.create :email_sent, user_id: user.id, type: apply_status}

  subject {email_sent}
  before do
    sign_in user
    request.host = "#{company.subdomain}.lvh.me:3000"
  end

  describe "GET #index" do
    context "get index success" do
      before :each do
        get :index, xhr: true
      end

      it "assigns the requested job to @job" do
        expect(assigns(:email_sents)).to be_truthy
      end

      it "renders the #index view" do
        expect(response).to render_template "employers/send_emails/index"
      end
    end
  end

  describe "GET #show" do
    context "get show success" do
      before :each do
        get :show, xhr: true, params: {id: email_sent.id}
      end

      it "assigns the requested email_sent to @email_sent" do
        expect(assigns(:email_sent)).to be_truthy
      end

      it "assigns the requested email_sent to @email_sent" do
        expect(assigns(:oauth)).to be_truthy
      end

    end
  end
end
