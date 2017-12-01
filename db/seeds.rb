# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
1.upto(5) do |x|
  name = Faker::Name.name
  email = "employer#{x}@gmail.com"
  pass = "123123"
  pass_conf = "123123"
  role = "employer"
  User.create!(name: name, email: email, password: pass,
               password_confirmation: pass_conf, role: role)
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

Company.create!(
  name: "Framgia",
  phone: Faker::Number.number(10),
  address: "DN",
  majors: "IT-Software",
  contact_person: "Nguyen Van A",
  company_info: "Framgia Da Nang City",
  logo: "framgia_logo.png",
  banner: "framgia_banner.jpg"
)

User.create!(name: "Ho Minh Huy", email: "minhhuyho2011@gmail.com", password: "123456")

Member.create!(
  company_id: 1,
  user_id: 1,
  position: "employer"
)

100.times do |i|
  Job.create!(
    company_id: 1,
    user_id: 1,
    name: Faker::Job.title,
    min_salary: 500,
    max_salary: 1000,
    content: Faker::Lorem.paragraphs,
    level: "University",
    language: "Vietnamese, Japan",
    skill: Faker::Job.key_skill,
    position: "Manager",
    description: Faker::Lorem.paragraphs
)
end

20.times do |i|
  Apply.create!(
    status: 0,
    user_id: 1,
    job_id: 1 + i
)
end
