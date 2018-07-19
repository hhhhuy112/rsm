FactoryGirl.define do
  factory :skill do
    name Faker::Name.name
    association :company, factory: :company
  end
end
