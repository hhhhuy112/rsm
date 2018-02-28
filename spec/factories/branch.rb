FactoryGirl.define do
  factory :branch do
    name "ho minh huy"
    phone Faker::Number.number(10)
    street "255 - 257 Hung Vuong"
    ward "Thach Thang"
    district "Hai Chau"
    province "Da Nang"
    country "Vietnam"
  end
end
