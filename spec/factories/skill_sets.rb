FactoryGirl.define do
  factory :skill_set do
    association :skill, factory: :skill
    association :interview_type, factory: :interview_type
  end
end
