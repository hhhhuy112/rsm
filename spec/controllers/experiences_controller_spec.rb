require "rails_helper"

RSpec.describe ExperiencesController, type: :controller do
  let(:user) {FactoryGirl.create :user}
  let(:experience) {FactoryGirl.create :experience, user_id: user.id}

  subject {experience}

  before {sign_in user}

  describe "GET #edit" do
    before :each do
      get :edit, xhr: true, params: {id: experience.id}
    end

    it "assigns the requested experience to @experience" do
      expect(assigns(:experience)).to eq experience
    end
    it "renders the #edit view" do
      expect(response).to render_template :edit
    end
  end

  describe "PATCH #update" do
    it "update experience success" do
      patch :update, params: {id: experience.id, experience:{name: "Framgia Sys", company: "Framgia",
        start_time: 100.day.ago, end_time: 10.day.ago, user_id: user.id}},
          xhr: true, format: "js"
      expect(flash[:success]).to match(I18n.t("experiences.update.update_success"))
    end
    it "update experience fail" do
      patch :update, params: {id: experience.id, experience:{name: "", start_time: "12/11/2017"}},
        xhr: true, format: "js"
    end
  end

  describe "POST #create" do
    it "create experience success" do
      post :create, params: {experience:{name: "Framgia Sys", company: "Framgia",
        start_time: 100.day.ago, end_time: 10.day.ago, user_id: user.id}},
          xhr: true, format: "js"
      expect(flash[:success]).to match(I18n.t("experiences.create.create_success"))
    end
    it "create experience fail" do
      post :update, params: {id: experience.id, experience:{name: "", start_time: "12/11/2017"}},
        xhr: true, format: "js"
    end
  end

  describe "DELETE #destroy" do
    it "destroy experience success" do
      delete :destroy, params: {id: experience.id}, xhr: true, format: "js"
      expect(flash[:success]).to match(I18n.t("experiences.destroy.destroy_success"))
    end
  end
end
