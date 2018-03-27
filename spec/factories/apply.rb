FactoryGirl.define do
  factory :apply do
    association :user, factory: :user
    association :job, factory: :job
    status 0
    cv File.new File.expand_path(Rails.root.join("lib", "seeds", "template_cv.pdf"))
    information {{ name: "Phan Dinh Lam", email: "user@gmail.com",
    phone: Faker::Number.number(10), introducing: Faker::Lorem.sentence(50)}}

    after :create do |apply|
      apply.update_attributes cv: "template_cv.pdf"
    end
  end
end
