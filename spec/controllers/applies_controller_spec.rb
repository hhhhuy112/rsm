require "rails_helper"

RSpec.describe AppliesController, type: :controller do
  let!(:user) {FactoryGirl.create :user, confirmed_at: Time.current}
  let(:company) {FactoryGirl.create :company}
  let(:branch) {FactoryGirl.create :branch, company_id: company.id}
  let(:category) {FactoryGirl.create :category, company_id: company.id}

  let :job do
    FactoryGirl.create :job, company_id: company.id,
      branch_id: branch.id, category_id: category.id
  end
end
