FactoryGirl.define do
  factory :question do
    association :job, factory: :job
    name {Faker::Name.name}
  end
end
