namespace :company_data do
  desc "Auto generate template_benefits data"
  task generate_template_skill_data: :environment do
    Company.all.each do |company|
      Template.create! title: Faker::Job.field, user_id: 1, company_id: company.id,
        type_of: :template_skill, template_body: Faker::Job.key_skill, name: Faker::Job.field
    end
  end
end
