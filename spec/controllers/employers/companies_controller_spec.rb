require "rails_helper"

RSpec.describe Employers::CompaniesController, type: :controller do
  describe "GET index" do
    it "has a 200 status code" do
      get :index
      end
  end
end
