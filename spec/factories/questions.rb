FactoryGirl.define do
  factory :question do
    association :company, factory: :company
    name {Faker::Name.name}
  end
end
