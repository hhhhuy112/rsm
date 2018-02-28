FactoryGirl.define do
  factory :company do
    name "Framgia_Inc"
    address "Da nang"
    phone "+84-(111)-999-" + Faker::Number.number(4)
    majors "IT_softeware"
    contact_person "Nguyen Van B"
    company_info "Framgia_Inc da nang"
    url_company "https://recruit.framgia.vn"
    subdomain "framgia"
  end
end
