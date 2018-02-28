require "rails_helper"

RSpec.describe Employers::JobsController, type: :controller do
  let!(:user) {FactoryGirl.create :user, confirmed_at: Time.current}
  let(:company) {FactoryGirl.create :company}
  let(:branch) {FactoryGirl.create :branch, company_id: company.id}
  let(:category) {FactoryGirl.create :category, company_id: company.id}
  let!(:member) {FactoryGirl.create :member, company_id: company.id, user_id: user.id}
  let :job do
    FactoryGirl.create :job, company_id: company.id, branch_id: branch.id, category_id: category.id
  end
  subject {job}
  before { sign_in user }

  describe "DELETE #destroy" do
    before {request.host = "#{company.subdomain}.lvh.me:3000"}
    it "destroy job" do
      delete :destroy, params: {id: subject.id},
        xhr: true, format: "js"
      expect(assigns[:message]).to match I18n.t("jobs.destroy.job_destroyed")
    end
  end
end
