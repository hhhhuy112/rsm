require "rails_helper"

RSpec.describe BookmarkLikesController, type: :controller do
  let(:user) {FactoryGirl.create :user, confirmed_at: Time.current}
  let(:company) {FactoryGirl.create :company}
  let(:branch) {FactoryGirl.create :branch, company_id: company.id}
  let(:category) {FactoryGirl.create :category, company_id: company.id}
  let :job do
    FactoryGirl.create :job, company_id: company.id, branch_id: branch.id, category_id: category.id
  end
  let(:bookmark_like) {FactoryGirl.create :bookmark_like, job_id: job.id}

  subject {bookmark_like}

  before {sign_in user}

  describe "POST #create" do
    it "create bookmark_like success" do
      post :create, params: {bookmark_like: {bookmark:
        "bookmark", user_id: user.id, job_id: job.id}, :format => :json}, xhr: true, format: "js"
      expect(assigns[:success]).to match I18n.t("bookmark_likes.create")
    end

    it "create bookmark_like fail" do
      post :create, params: {bookmark_like:{bookmark: "bookmark", user_id: 100}},
        xhr: true, format: "js"
    end
  end

  describe "DELETE #destroy" do
    it "destroy bookmark_like success" do
      delete :destroy, params: {id: subject.id}, xhr: true, format: "js"
      expect(assigns[:success]).to match I18n.t("bookmark_likes.destroy_success")
    end
  end
end
