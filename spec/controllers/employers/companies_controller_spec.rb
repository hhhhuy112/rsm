require "rails_helper"

RSpec.describe Employers::CompaniesController, type: :controller do
  let(:company) {FactoryGirl.create :company}
  let(:user) {FactoryGirl.create :user, confirmed_at: Time.current,
    role: "employer", company_id: company.id}
  subject {company}

  before {
   sign_in user
   allow(controller).to receive(:check_permissions_employer).and_return(true)
   allow(controller).to receive(:current_ability).and_return(true)
   allow(controller).to receive(:load_notifications).and_return(true)
   allow(controller).to receive(:authorize!).and_return(true)
   request.host = "#{subject.subdomain}.lvh.me:3000"
  }

  describe "PATCH #update" do
    context "update success" do
      it "update with name" do
        patch :update, params: {id: subject.id, company:{name: "samsung"}}
        expect(response).to redirect_to edit_employers_company_path
      end
    end

    context "update faild" do
      it "update with name" do
        patch :update, params: {id: subject.id, company:{name: ""}}
        expect(response).to render_template "employers/companies/edit"
      end
    end
  end
end
