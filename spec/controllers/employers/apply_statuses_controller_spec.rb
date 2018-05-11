require "rails_helper"

RSpec.describe Employers::ApplyStatusesController, type: :controller do
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
    FactoryGirl.create :apply, user_id: user.id, job_id: job.id,
      cv: File.new(Rails.root.join("lib", "seeds", "template_cv.pdf")),
      information: Hash[
        name: Faker::Name.name,
        email: "user@gmail.com",
        phone: Faker::Number.number(10),
        introducing: Faker::Lorem.sentence(50)
      ]
  end
  let!(:apply_status) do
    FactoryGirl.create :apply_status, apply_id: apply.id, status_step_id: status_step.id
  end

  subject {apply_status}
  before {sign_in user}

  describe "GET #show" do
    before {request.host = "#{company.subdomain}.lvh.me:3000"}

    context "show success" do
      before :each do
        get :show, xhr: true, params: {id: subject.id}
      end

      it "assigns the requested job to @job" do
        expect(assigns(:apply_status)).to eq subject
      end

      it "renders the #show view" do
        expect(response).to render_template "employers/apply_statuses/show"
      end
    end

    context "update faild" do
      before :each do
        get :show, xhr: true, params: {id: 2}
      end

      it "not found apply_status" do
        expect(response).to render_template "errors/error"
      end
    end
  end
end

