FactoryGirl.define do
  factory :knowledge do
    association :evaluation, factory: :evaluation
    association :skill, factory: :skill
    score "good"
  end
end
