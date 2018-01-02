# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.delete_all
User.create!(name: "Nguyen Van A", email: "nguyenvana@gmail.com", password: "123456", phone: "01698624222")
1.upto(5) do |x|
  name = Faker::Name.name
  email = "employer#{x}@gmail.com"
  address = "Tam Ky, Da Nang"
  pass = "123123"
  pass_conf = "123123"
  role = "employer"
  phone = "0965600364"
  User.create!(name: name, email: email, password: pass,
               password_confirmation: pass_conf, role: role, address: address, phone: phone)
end
1.upto(5) do |x|
  name = Faker::Name.name
  email = "user#{x}@gmail.com"
  pass = "123123"
  pass_conf = "123123"
  role = "user"
  User.create!(name: name, email: email, password: pass,
               password_confirmation: pass_conf, role: role)
end

1.upto(10) do |x|
  1.upto(5) do
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

Company.delete_all
Company.create!(
  name: "Framgia",
  email: "framrecruit@gmail.com",
  phone: Faker::Number.number(10),
  address: "DN",
  majors: "IT-Software",
  contact_person: "Nguyen Van A",
  company_info: "Framgia Da Nang City",
  logo: Rails.root.join("public/uploads/company/logo/1/logo_default.png").open,
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

company = Company.all
2.times do |n|
  company.each { |company| company.branches.create!(
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
  company.each { |company| company.categories.create!(
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
    category_id: 1
  )}
end
1.upto(10) do |x|
  Partner.create!(
    name: Faker::Name.name,
    email: "partner#{x}@gmail.com",
    description: "partner",
    company_id: 1
  )
  Activity.create!(
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
1.upto(2) do |x|
  Template.create!(
    template_body:
      '<div class="container"><div class="body-build"><div class="body-first">
      <div class="first-a"><div class="start-body"><div class="a-left"><a>@image_company@</a>
      <div class="month">FRAMGIA RECRUIT</div></div></div>
      <div class="clear-both"></div></div><div class="c-first"></div>
      <div class="b-body"><div class="menu-body"><h2>Your application has been received</h2>
      <b class="title-first">Hello you@user_name@</b><p class="count">You have an interview with you
      @name_applied@Please arrange time for the interview to take place well,</p>
      <h2>Good luck</h2></div><div class="bodyname"><div class="floatl">@agree@</div>
      <div class="floata">@not_agree@</div><div class ="clear"></div>
      <div class= "margin-top"></div><div class="botlast"><div class="secondlast">
      <div class="vooter">@image_framgia@</div>
      <div class="bottom-high"><p style="" class="font-last">255-257 Hung vuong, Hai Chau, Da Nang
      </p></div></div></div></div></div></div></div></div>',
    user_id: 1,
    name: Faker::Name.name,
    type_of: x-1
  )
end
