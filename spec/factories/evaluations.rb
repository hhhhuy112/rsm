FactoryGirl.define do
  factory :evaluation do
    association :apply, factory: :apply
    association :interview_type, factory: :interview_type
  end
end
