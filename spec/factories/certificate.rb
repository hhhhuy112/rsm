FactoryGirl.define do
  factory :certificate do
    name "MinhMicheal"
    majors "SoftwareEngineering"
    organization "123 London, United Kingdom"
    classification "Good"
    received_time "05/11/2017"
    association :user, factory: :user
  end
end

