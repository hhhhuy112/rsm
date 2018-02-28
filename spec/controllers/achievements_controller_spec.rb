require "rails_helper"

RSpec.describe AchievementsController, type: :controller do
  let(:achievement) {FactoryGirl.create :achievement}
  let(:user) {FactoryGirl.create :user, confirmed_at: Time.current}
  subject {achievement}
  before {sign_in user}

  describe "POST #create" do
    it "create achievement success" do
      post :create, params: {achievement: {name: "phamducpho", majors: "CNTT",
        organization: "Da Nang city", received_time: "01/02/2017", user_id: user.id}},xhr: true, format: "js"
      expect(assigns[:message]).to eq I18n.t("achievements.create_success")
    end

    it "create achievement fail" do
      post :create, params: {id: subject.id, achievement:{name: "", majors: "CNTT"}},
        xhr: true, format: "js"
    end
  end
end
