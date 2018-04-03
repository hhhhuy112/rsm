require "rails_helper"

RSpec.describe Employers::AppliesController, type: :controller do
  let(:user) {FactoryGirl.create :user, confirmed_at: Time.current}
  let(:company) {FactoryGirl.create :company}
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
  let!(:company_step) {FactoryGirl.create :company_step, company_id: company.id, step_id: step.id}

  subject {apply}
  before do
    sign_in user
    request.host = "#{company.subdomain}.lvh.me:3000"
  end

  describe "GET #index" do
    context "index applies" do
      before :each do
        get :index
      end

      it "assigns the requested activities to @activities" do
        expect(assigns(:activities)).to be_truthy
      end

      it "assigns the requested applies_status to @applies_status" do
        expect(assigns(:applies_status)).to be_truthy
      end

      it "assigns the requested size_steps to @size_steps" do
        expect(assigns(:size_steps)).to be_truthy
      end

      it "renders the #create view" do
        expect(response).to render_template "employers/applies/index"
      end
    end
  end

  describe "POST #create" do
    context "create success" do
      before :each do
        cv = fixture_file_upload("template_cv.pdf", "text/pdf")
        post :create, xhr: true, params: {choosen_ids: ",#{job.id}", apply: {information: {
          name: "NguyenVanA", email: "user12@example.com", phone: "1234567890"
          }, cv: cv}}
      end

      it "assigns the requested success to @success" do
        expect(assigns(:success)).to eq I18n.t("employers.applies.create.success")
      end

      it "renders the #create view" do
        expect(response).to render_template "employers/applies/create"
      end
    end

    context "create duplicate" do
      before :each do
        cv = fixture_file_upload("template_cv.pdf", "text/pdf")
        post :create, xhr: true, params: {choosen_ids: ",#{job.id}", apply: {information: {
          name: "NguyenVanA", email: User.first.email, phone: "1234567890"}, cv: cv}}
      end

      it "assigns the requested error" do
        expect(assigns(:error)).to be_truthy
      end
    end

    context "craete RecordInvalid" do
      before :each do
        post :create, xhr: true, params: {choosen_ids: ",#{job.id}", apply: {information: {
          name: "NguyenVanA", email: "psrsson1@example.com"}}}
      end

      it "assigns the requested error_record_invalid" do
        expect(assigns(:error)).to eq I18n.t("employers.applies.create.failure_user")
      end
    end

    context "craete fail with no job" do
      before :each do
        post :create, xhr: true, params: {choosen_ids: "", apply: {information: {
          name: "NguyenVanA", email: "psrsson1@example.com"}}}
      end

      it "assigns the requested error_record_invalid" do
        expect(assigns(:error)).to eq I18n.t("employers.applies.create.job_nil")
      end
    end
  end
end
