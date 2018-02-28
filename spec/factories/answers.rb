FactoryGirl.define do
  factory :answer do
    association :apply, factory: :apply
    association :question, factory: :question
    name {Faker::Name.name}
  end
end
