FactoryGirl.define do
  factory :experience do
    name {Faker::Name.name}
    association :user_id
    created_at Date.today
    updated_at Date.today
    company {Faker::Job.title}
    start_time Time.zone.today - 1
    end_time Time.zone.today
    project_detail {Faker::Lorem.paragraph}
  end
end
