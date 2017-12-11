FactoryGirl.define do
  factory :ability do
    status 0
    association :user, factory: :user
    association :job, factory: :job
  end
end
