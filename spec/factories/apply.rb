FactoryGirl.define do
  factory :apply do
    status 0
    association :user, factory: :user
  end
end
