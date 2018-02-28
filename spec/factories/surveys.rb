FactoryGirl.define do
  factory :survey do
    association :question, factory: :question
    association :job, factory: :job
  end
end
