require "rails_helper"

RSpec.describe CertificatesController, type: :controller do
  let(:user) {FactoryGirl.create :user, confirmed_at: Time.current}
  let(:certificate) {FactoryGirl.create :certificate, user_id: user.id}
  subject {certificate}
  before {sign_in user}

  describe "PATCH #update" do
    it "update certificate success" do
      patch :update, params: { id: subject.id, certificate:{name: "Lyly", majors: "IT",
        organization: "123 Da Nang", classification: "Bad", received_time: "5/9/2017", user_id: user.id}}, xhr: true, format: "js"
      expect(assigns[:message]).to match I18n.t("certificate.update_success")
    end

    it "update certificate fail" do
      patch :update, params: { id: subject.id, certificate:{name: "", received_time: "5/9/2017"}}, xhr: true, format: "js"
    end
  end

  describe "POST #create" do
    it "create certificate success" do
      post :create, params: {certificate:{name: "Minh", majors: "Bank", organization: "1231 Da Nang", classification: "Bad", received_time: "5/9/2017", user_id: user.id}}, xhr: true, format: "js"
      expect(assigns[:message]).to match I18n.t("certificate.create_success")
    end

    it "create certificate fail" do
      post :update, params: { id: subject.id, certificate:{name: "", received_time: "12/11/2017"}}, xhr: true, format: "js"
    end
  end

  describe "DELETE #destroy" do
    it "destroy certificate success" do
      delete :destroy, params: {id: subject.id}, xhr: true, format: "js"
      expect(assigns[:success]).to match I18n.t("certificate.destroy_success")
    end
  end
end
