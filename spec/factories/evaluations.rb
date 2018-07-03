FactoryGirl.define do
  factory :evaluation do
    association :apply, factory: :apply
  end
end
