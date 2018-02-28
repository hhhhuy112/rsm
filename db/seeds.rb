# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Company.delete_all
Company.create!(
  name: "Framgia",
  email: "framrecruit@gmail.com",
  phone: Faker::Number.number(10),
  address: "DN",
  majors: "IT-Software",
  contact_person: "Nguyen Van A",
  company_info: "Framgia Da Nang City",
  # logo: Rails.root.join("public/uploads/company/logo/1/logo_default.png").open,
  banner: "framgia_banner.jpg",
  subdomain: "framgia"
)
Company.create!(
  name: "FSoft Da Nang",
  phone: Faker::Number.number(10),
  address: "Da Nang",
  email: "framrecruit@gmail.com",
  majors: "IT-Software",
  contact_person: "Pham Van B",
  company_info: "Fsoft Da Nang - FPT Complex",
  logo: "framgia.png",
  banner: "framgia_banner.jpg",
  subdomain: "fsoft"
)
User.delete_all
User.create!(name: "Nguyen Van A", email: "nguyenvana@gmail.com", password: "123456",
  phone: "01698624222", birthday: "1996-01-13", address: "Tam Ky, Quang Nam", company_id: 1)
User.create!(name: "Nguyen Van Pho", email: "nguyenvanb@gmail.com", password: "123456",
  phone: "01698624222", birthday: "1996-01-13", address: "Tam Ky, Quang Nam", company_id: 2)
1.upto(5) do |x|
  name = Faker::Name.name
  email = "employer#{x}@gmail.com"
  address = "Tam Ky, Da Nang"
  pass = "123123"
  pass_conf = "123123"
  birthday = Date.current
  role = "employer"
  phone = "0965600364"
  company_id = 1
  User.create!(name: name, email: email, password: pass, birthday: birthday,
               password_confirmation: pass_conf, role: role, address: address,
               phone: phone, company_id: company_id)
end
1.upto(5) do |x|
  name = Faker::Name.name
  email = "user#{x}@gmail.com"
  pass = "123123"
  birthday = Date.current
  pass_conf = "123123"
  role = "user"
  phone = "0965600364"
  company_id = 1
  User.create!(name: name, email: email, password: pass,
               password_confirmation: pass_conf, role: role, birthday: birthday, company_id: company_id)
end

1.upto(2) do |x|
  1.upto(2) do
    name =   Faker::Team.creature << " Club"
    position = Faker::Job.title
    start_time = Faker::Date.between(1000.days.ago, 100.days.ago)
    current = rand(2)
    if current==0
      end_time = Faker::Date.between(99.days.ago, Date.today)
    end
    content = Faker::Lorem.paragraph << Faker::Lorem.paragraph
    Club.create!(name: name, user_id: x, position: position,
      start_time: start_time, end_time: end_time, content: content, current: current)
  end
end

1.upto(2) do |x|
  1.upto(2) do
    name =  Faker::Company.name
    majors = Faker::Job.title
    received_time = Faker::Date.between(1000.days.ago, 100.days.ago)
    organization = Faker::Address.street_name
    Achievement.create!(name: name, user_id: x, majors: majors,
      received_time: received_time, organization: organization)
  end
end

1.upto(2) do |x|
  1.upto(2) do
    name =  Faker::Company.name
    majors = Faker::Job.title
    received_time = Faker::Date.between(1000.days.ago, 100.days.ago)
    organization = Faker::Address.street_name
    classification = "Good"
    Certificate.create!(name: name, user_id: x, majors: majors,
      received_time: received_time, organization: organization,
      classification: classification)
  end
end

1.upto(2) do |x|
  1.upto(2) do
    name = Faker::Name.name_with_middle
    company =  Faker::Company.name
    start_time = Faker::Date.between(1000.days.ago, 100.days.ago)
    end_time = Faker::Date.between(99.days.ago, Date.today)
    project_detail = Faker::Lorem.paragraph << Faker::Lorem.paragraph
    Experience.create!(name: name, user_id: x, company: company,
      start_time: start_time, end_time: end_time,
      project_detail: project_detail)
  end
end

User.update_all confirmed_at: Time.current

Branch.delete_all
Branch.create!(
  is_head_office: 1,
  name: "Hanoi Office",
  phone: Faker::Number.number(10),
  street: "13F Keangnam Landmark 72 Tower, Plot E6, Pham Hung Road",
  ward: "",
  district: "Nam Tu Liem",
  province: "Ha Noi",
  country: "Vietnam",
  status: 0,
  company_id: 1
)

Branch.create!(
  is_head_office: 1,
  name: "FPT Complex",
  phone: Faker::Number.number(10),
  street: "FPT Complex Building",
  ward: "Hoa Hai",
  district: "Ngu Hanh Son",
  province: "Da Nang",
  country: "Vietnam",
  status: 0,
  company_id: 2
)

statuses = {
  review: [:pending, :review_not_selected, :review_passed],
  test: [:pending, :test_scheduled, :test_passed, :test_not_selected],
  interview: [:pending, :interview_scheduled, :interview_passed, :interview_not_selected],
  offer: [:pending, :offer_sent, :offer_accepted, :offer_declined, :joined],
}

statuses.each_with_index do |(key, value), index|
  Step.create!(
    description: "#{key}",
    name: "#{key}",
  )

  next if statuses[key].blank?
  statuses[key].each do |val|
    StatusStep.create!(
      step_id: Step.all[index].id,
      name: "#{val}",
      code: "#{val}"

      )
  end
end

companies = Company.all

companies.each do |company|
  Step.all.each_with_index do |step, index|
    CompanyStep.create!(
      company_id: company.id,
      step_id: step.id,
      priority: index + 1
    )
  end
end

companies.each do |company|
  CompanySetting.create!(
    company_id: company.id,
    enable_send_mail: {
      waitting: true,
      review_passed: true,
      review_not_selected: true,
      test_scheduled: true,
      test_passed: true,
      test_not_selected: true,
      interview_scheduled: true,
      interview_passed: true,
      interview_not_selected: true,
      offer_sent: true, offer_accepted: true, offer_declined: true, joined: true
    }
  )
end


2.times do |n|
  companies.each { |company| company.branches.create!(
    is_head_office: 0,
    name: Faker::Address.street_name,
    phone: Faker::Number.number(10),
    street: Faker::Address.street_address,
    ward: Faker::Address.city_prefix,
    district: Faker::Address.city_prefix,
    province: Faker::Address.city,
    status: 0,
    country: "Vietnam",

  )}
end

Category.delete_all
2.times do |n|
  companies.each { |company| company.categories.create!(
    name: Faker::Job.title,
    description: Faker::Lorem.sentences(1),
    status: 0
  )}
end

Member.delete_all
Member.create!(
  company_id: 1,
  user_id: 1,
  role: 1,
  position: "employer",
  start_time: Date.current - 1.years
)
Member.create!(
  company_id: 2,
  user_id: 2,
  role: 1,
  position: "employer",
  start_time: Date.current - 1.years
)

Job.delete_all
2.times do |n|
  Branch.all.each { |branch|
    Job.create!(
    content: Faker::Lorem.paragraphs,
    name: Faker::Job.title,
    level: "University",
    company_id: 1,
    user_id: 11,
    min_salary: 500,
    max_salary: 1000,
    language: "Vietnamese, Japan",
    skill: Faker::Job.key_skill,
    position: "Manager",
    description: Faker::Lorem.paragraphs,
    branch_id: branch.id,
    category_id: 1,
    target: 10,
    end_time: Date.current + 1.years
  )}
end

Job.limit(10).each_with_index do |job, index|
  user = User.find index + 1
  apply = Apply.create!(
    status: "unlock_apply",
    user_id: index + 1,
    job_id: index + 1,
    cv: File.new(Rails.root.join("lib", "seeds", "template_cv.pdf")),
    information: {
      name: user.name,
      email: user.email,
      phone: Faker::Number.number(10),
      introducing: "abc"
    }
  )
  ApplyStatus.create!(
    apply_id: apply.id,
    status_step_id: StatusStep.first.id,
    is_current: :current
  )
end

# Apply.all.each do |apply|
#  start_time = Faker::Time.forward(23, :morning)
#   apply.appointments.create!(
#     address: Faker::Job.title ,
#     start_time: start_time,
#     end_time: (start_time + 2.hours),
#     type_appointment: "test_scheduled",
#     company_id: 1
#   )
# end

1.upto(10) do |x|
  Partner.create!(
    name: Faker::Name.name,
    email: "partner#{x}@gmail.com",
    description: "partner",
    company_id: 1
  )
  CompanyActivity.create!(
    title: "Hour of code: Children – Make friend with computers",
    description: "Hour of code: Children – Make friend with computers",
    company_id: 1
  )
end
1.upto(10) do |x|
  RewardBenefit.create!(
    content: Faker::Name.name,
    job_id: 1
  )
end
Template.create!(
  template_body:"@company@
    Xin Chào bạn @user@
    Chúng tôi xin thông báo với bạn rằng cv của bạn đang được xem xét, chúng tôi sẽ phản hồi cho bạn sớm nhất có thể.
    Chúc bạn một ngày tốt lành",
  user_id: 1,
  name: "template review",
  title: "Thông báo về việc xem xét cv",
  type_of: 1
)
Template.create!(
  template_body:"@company@
    Xin Chào bạn @user@
    Chúng tôi xin thông báo với bạn rằng bạn đã passed vào vòng trong của cuộc phỏng vấn tại Framgia, xin chúc mừng bạn.
    Chúc bạn một ngày tốt lành",
  user_id: 1,
  name: "template passed",
  title: "Thông báo bạn đã passed vào vòng trong",
  type_of: 1
)
Template.create!(
  template_body:"@company@
    Xin Chào bạn @user@<br>
    Chúng tôi xin thông báo với bạn rằng cv của bạn đang được chọn, vui lòng đến
    vào lúc @start_time@ tại @address@ để phỏng vấn, chậm nhất là vào @end_time@
    Rất mong bạn đến đúng giờ
    Chúc bạn một ngày tốt lành",
  user_id: 1,
  title: "Thông báo gửi lịch hẹn phỏng vấn",
  name: "template interview",
  type_of: 1
)
Template.create!(
  template_body:"<p>@company@<br />
  Hello you @user@<br />
  We would like to send you a mail to inform you that from @date_offer@ is your official time,
  the place is @offer_address@. Your starting salary is @ salary @, however this number may increase according to your capacity.
  Also we have some requirements such as @requirement@</p>
  ",
  user_id: 1,
  title: "Thông báo gửi offer",
  name: "template offer",
  type_of: 1
)

1.upto(10) do |n|
  Question.create! name: Faker::Lorem.sentence, company_id: 1
end

Job.limit(5).each do |job|
  2.times do |n|
    job.update_attributes survey_type: 1
    job.surveys.create! question_id: rand(1..10)
  end
end

Job.limit(2).each do |job|
  2.times do |n|
    job.update_attributes survey_type: 2
    job.surveys.create! question_id: rand(1..10)
  end
end
