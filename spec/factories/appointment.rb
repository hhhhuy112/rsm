FactoryGirl.define do
  factory :appointment do
    address {Faker::Address.street_address}
    start_time {Faker::Time.forward(23, :morning)}
    end_time {Faker::Time.forward(25, :morning)}
    company_id {Faker::Number.digit}
    apply_id {Faker::Number.digit}
  end
end
