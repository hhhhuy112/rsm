FactoryGirl.define do
  factory :company_step do
    association :company, factory: :company
    association :step, factory: :step
    priority 1
  end
end
