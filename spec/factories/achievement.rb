FactoryGirl.define do
  factory :achievement do
    name "Tran anh tuan"
    majors "IT"
    received_time "2017-11-01"
    organization "Da Nang university"
    association :user, factory: :user
  end
end
