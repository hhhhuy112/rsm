FactoryGirl.define do
  factory :job do
    name Faker::Lorem.name
    content Faker::Lorem.paragraphs
    level "University"
    language "Vietnamese, Japan"
    skill Faker::Job.key_skill
    position "Manager"
    min_salary 400
    max_salary 500
    description Faker::Lorem.paragraphs
    association :user, factory: :user
    association :company, factory: :company
  end
end
