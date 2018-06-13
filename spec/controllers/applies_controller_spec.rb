require "rails_helper"

RSpec.describe AppliesController, type: :controller do
  let(:company) {FactoryGirl.create :company}
  let(:currency) {FactoryGirl.create :currency, company_id: company.id}
  let(:user) {FactoryGirl.create :user, confirmed_at: Time.current, company_id: company.id}
  let(:branch) {FactoryGirl.create :branch, company_id: company.id}
  let(:category) {FactoryGirl.create :category, company_id: company.id}
  let(:step) {FactoryGirl.create :step}
  let!(:member) {FactoryGirl.create :member, company_id: company.id, user_id: user.id}
  let(:status_step) {FactoryGirl.create :status_step, step_id: step.id}
  let :job do
    FactoryGirl.create :job, company_id: company.id, branch_id: branch.id,
      category_id: category.id, user_id: user.id, currency_id: currency.id
  end
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

  describe "POST #create" do
    context "create success" do
      before :each do
        cv = fixture_file_upload("template_cv.pdf", "text/pdf")
        post :create, xhr: true, params: {apply: {job_id: job.id, information: {
          name: "NguyenVanA", email: "user@example.com", phone: "1234567890"
          }, cv: cv}}
      end

      it "assigns the requested success to @success" do
        expect(assigns(:success)).to be_truthy
      end

      it "renders the #create view" do
        expect(response).to render_template "applies/create"
      end
    end

    context "craete duplicate" do
      before :each do
        cv = fixture_file_upload("template_cv.pdf", "text/pdf")
        post :create, xhr: true, params: {apply: {job_id: job.id, information: {
          name: "NguyenVanA", email: User.first.email, phone: "1234567890"
          }, cv: cv}}
      end

      it "assigns the requested error" do
        expect(assigns(:error)).to eq I18n.t("applies.create.duplicate_apply")
      end
    end

    context "craete RecordInvalid" do
      before :each do
        post :create, xhr: true, params: {apply: {job_id: job.id, information: {
          name: "NguyenVanA", email: "psrsson1@example.com", phone: "1234567890"}}}
      end

      it "assigns the requested error_record_invalid" do
        expect(assigns(:error_record_invalid)).to eq I18n.t("apply.user_fail")
      end
    end
  end
end
