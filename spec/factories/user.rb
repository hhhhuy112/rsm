FactoryGirl.define do
  factory :user do
    name "phopham"
    password "123456"
    password_confirmation "123456"
    sex 1
    role "admin"
    phone "0965600364"
    sequence(:email) {|n| "psrsson#{n}@example.com" }
    address "Tam Ky"
    birthday "1996-01-13"
  end
end
