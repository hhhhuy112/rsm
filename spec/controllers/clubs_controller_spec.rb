require "rails_helper"

RSpec.describe ClubsController, type: :controller do
  let(:user) {FactoryGirl.create :user, confirmed_at: Time.current}
  let(:club) {FactoryGirl.create :club, user_id: user.id}
  subject {club}
  before { sign_in user }

  describe "PATCH #update" do
    it "update club success" do
      patch :update, params: { id: subject.id, club:{name: "Vux.", position: "member", start_time: 100.day.ago, end_time: 10.day.ago, user_id: user.id}}, xhr: true, format: "js"
      expect(assigns[:message]).to match I18n.t("clubs.update_success")
    end

    it "update club fail" do
      patch :update, params: { id: subject.id, club:{name: "", start_time: "12/11/2017"}},
        xhr: true, format: "js"
    end
  end

  describe "POST #create" do
    it "create club success" do
      post :create, params: {club:{name: "Vux.", position: "member", start_time: 100.day.ago, end_time: 10.day.ago, user_id: user.id}}, xhr: true, format: "js"
      expect(assigns[:message]).to match I18n.t("clubs.create_success")
    end

    it "create club fail" do
      post :update, params: { id: subject.id, club:{name: "",start_time: "12/11/2017"}}, xhr: true, format: "js"
    end
  end

  describe "DELETE #destroy" do
    it "destroy club success" do
      delete :destroy, params: {id: subject.id}, xhr: true, format: "js"
      expect(assigns[:success]).to match I18n.t("clubs.destroy_success")
    end
  end
end
