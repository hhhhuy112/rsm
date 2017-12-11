require "rails_helper"

RSpec.describe AppliesController, type: :controller do

  describe "POST #create" do
    it "apply success" do
      post :create, params: {apply:{status: 0, user_id: User.first.id, job_id: Job.first.id} },
          xhr: true, format: "js"
      expect(flash[:success]).to match(I18n.t "certificate.success")
    end

    it "apply fail" do
      post :update, params: { id: apply.id, apply:{status: 0, user_id: "", job_id: Job.first.id} },
        xhr: true, format: "js"
      expect(flash[:danger]).to match(I18n.t "certificate.fail")
    end
  end
end
