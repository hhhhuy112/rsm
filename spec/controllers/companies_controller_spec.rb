require "rails_helper"

RSpec.describe CompaniesController, type: :controller do
  let!(:user) {FactoryGirl.create :user, confirmed_at: Time.current}
  let(:company) {FactoryGirl.create :company}
  subject {company}
  before { sign_in user }

  describe "PATCH #update" do
    before {request.host = "#{subject.subdomain}.lvh.me:3000"}
    context "update success" do
      it "update with name " do
        patch :update, params: {id: subject.id, company:{name: "samsung"}}
        expect(flash[:success]).to match I18n.t("companies.update_success")
        expect(response).to redirect_to(company_path)
      end
    end

    context "update faild" do
      it "update with name" do
        patch :update, params: {id: subject.id, company:{name: ""}}
        expect(response).to redirect_to(company_path)
      end
    end
  end
end
