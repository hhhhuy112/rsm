require "rails_helper"

RSpec.describe Employers::NotesController, type: :controller do
  let(:user) {FactoryGirl.create :user, confirmed_at: Time.current, company_id: company.id}
  let(:company) {FactoryGirl.create :company}
  let(:branch) {FactoryGirl.create :branch, company_id: company.id}
  let(:category) {FactoryGirl.create :category, company_id: company.id}
  let(:step) {FactoryGirl.create :step}
  let!(:member) {FactoryGirl.create :member, company_id: company.id, user_id: user.id}
  let(:currency) {FactoryGirl.create :currency, company_id: company.id}
  let :job do
    FactoryGirl.create :job, company_id: company.id, branch_id: branch.id,
      category_id: category.id, currency_id: currency.id, user_id: user.id
  end
  let(:status_step) {FactoryGirl.create :status_step, step_id: step.id}
  let(:apply) do
    FactoryGirl.create :apply, user_id: user.id, job_id: job.id,
      information: { name: "Phan Dinh Lam", email: "user@gmail.com",
      phone: Faker::Number.number(10), introducing: Faker::Lorem.sentence(50)}
  end
  let(:apply) do
    FactoryGirl.create :apply, user_id: user.id, job_id: job.id
  end
  let!(:apply_status) do
    FactoryGirl.create :apply_status, apply_id: apply.id, status_step_id: status_step.id
  end
  let!(:note) do
    FactoryGirl.create :note, user_id: user.id, apply_id: apply.id
  end

  subject {note}
  before do
    sign_in user
    request.host = "#{company.subdomain}.lvh.me:3000"
  end

  describe "GET #new" do
    context "new success" do
      before :each do
        get :new, xhr: true, params: {apply_id: apply.id}
      end

      it "renders the #new view" do
        expect(response).to render_template "employers/notes/new"
      end
    end
  end

  describe "POST #create" do
    context "create success" do
      before :each do
        post :create, params: {apply_id: apply.id, note: {content: Faker::Lorem.paragraph,
          user_id: user.id, apply_id: apply.id}}, xhr: true
      end

      it "renders the #create view" do
        expect(response).to render_template "employers/notes/create"
      end

      it "create notes success with message" do
        expect(assigns[:success]).to match I18n.t("employers.notes.create.success")
      end
    end

    context "create fail" do
      before :each do
        post :create, params: {apply_id: apply.id, note: {user_id: user.id, apply_id: apply.id}},
          xhr: true
      end

      it "create notes fail with message" do
        expect(assigns[:note].errors.full_messages.present?).to be_truthy
      end
    end
  end

  describe "GET #edit" do
    context "edit success" do
      before :each do
        get :edit, xhr: true, params: {apply_id: apply.id, id: subject.id}
      end

      it "renders the #edit" do
        expect(response).to render_template "employers/notes/edit"
      end
    end
  end

  describe "patch #update" do
    context "update success" do
      before :each do
        patch :update, xhr: true, params: {apply_id: apply.id, id: subject.id,
          note: {content: Faker::Lorem.paragraph}}
      end

      it "renders the #update view" do
        expect(response).to render_template "employers/notes/update"
      end

      it "update success with message" do
        expect(assigns[:success]).to match I18n.t("employers.notes.update.updated_success")
      end
    end

    context "update fail" do
      before :each do
        patch :update, xhr: true, params: {apply_id: apply.id, id: subject.id,
          note: {content: ""}}
      end

      it "renders the #update view" do
        expect(response).to render_template "employers/notes/update"
      end

      it "update success with message" do
        expect(assigns[:note].errors).to be_truthy
      end
    end
  end


  describe "delete #destroy" do
    context "delete success" do
      before :each do
        delete :destroy, xhr: true, params: {apply_id: apply.id, id: subject.id}
      end

      it "renders the #destroy view" do
        expect(response).to render_template "employers/notes/destroy"
      end

      it "destroy success with message" do
        expect(assigns[:success]).to match I18n.t("employers.notes.destroy.destroyed_success")
      end
    end

    context "delete fail" do
      before :each do
        delete :destroy, xhr: true, params: {apply_id: apply.id, id: 10}
      end

      it "renders the not found object view" do
        expect(response).to render_template "errors/error"
      end
    end
  end
end

