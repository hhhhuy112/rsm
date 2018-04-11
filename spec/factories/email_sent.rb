FactoryGirl.define do
  factory :email_sent do
    association :user, factory: :user
    title "Thông báo passed"
    content Faker::Lorem.paragraph
    sender_email Faker::Internet.email
    receiver_email Faker::Internet.email
    association :type, factory: :apply_status
    status 0
  end
end
