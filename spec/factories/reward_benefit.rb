FactoryGirl.define do
  factory :reward_benefit do
    content "An trua mien phi"
    association :job, factory: :job
  end
end
