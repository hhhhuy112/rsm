FactoryGirl.define do
  factory :status_step do
    association :step, factory: :step
    name "pending"
    code "pending"
  end
end
