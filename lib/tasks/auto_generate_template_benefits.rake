namespace :company_data do
  desc "Auto generate template_benefits data"
  task generate_template_benefits_data: :environment do
    Company.all.each do |company|
      Template.create! title: Faker::Name.title , user_id: 1, company_id: company.id, type_of: :template_benefit,
        template_body: Faker::Lorem.sentence(100), name: Faker::Name.title
    end
  end
end
