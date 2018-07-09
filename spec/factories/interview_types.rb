FactoryGirl.define do
  factory :interview_type do
    association :company, factory: :company
    name "Intern/NewDev"
  end
end
