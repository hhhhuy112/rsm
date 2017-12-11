FactoryGirl.define do
  factory :bookmark_like do
    bookmark "bookmark"
    association :user, factory: :user
    association :job, factory: :job
  end
end
