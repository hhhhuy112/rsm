require "rails_helper"

RSpec.describe BookmarkLikesController, type: :controller do
  let(:user) {FactoryGirl.create :user}
  let(:job) {FactoryGirl.create :job}
  let(:bookmark_like) {FactoryGirl.create :bookmark_like}

  subject {bookmark_like}

  before {sign_in user}

  describe "GET #index" do
    before :each do
      get :index, xhr: true
    end

    it "responds successfully with an HTTP 200 status code" do
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end
  end

  describe "POST #create" do

    it "create bookmark_like success" do
      post :create, params: {bookmark_like: {bookmark: "bookmark", user_id: user.id, job_id: job.id}},
          xhr: true, format: "js"
      expect(flash[:success]).to match(I18n.t("bookmark_like.create"))
    end

    it "create bookmark_like fail" do
      post :create, params: {bookmark_like:{bookmark: "bookmark", user_id: 100}},
        xhr: true, format: "js"
    end
  end

  describe "DELETE #destroy" do

    it "destroy achievement" do
      delete :destroy, params: {id: subject.id}, xhr: true, format: "js"
      expect(flash[:success])
    end
  end
end
