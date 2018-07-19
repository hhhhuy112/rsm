namespace :module_interviewer_data do
  desc "Auto generate module interviewer data"
  task generate_module_interviewer_data: :environment do
    InterviewType.with_deleted.each { |interview_type| interview_type.really_destroy!}
    Skill.with_deleted.each { |skill| skill.really_destroy!}
    SkillSet.with_deleted.each { |skill_set| skill_set.really_destroy!}
    Company.all.each do |company|
      InterviewType.create!(
        name: "Intern/NewDev",
        company_id: company.id
      )

      InterviewType.create!(
        name: "HR",
        company_id: company.id
      )

      3.times do |n|
        Skill.create!(
          name: Faker::Name.name,
          company_id: company.id,
          type_skill: "basic"
        )
      end

      company.interview_types.each do |interview_type|
        Skill.all.each do |skill|
          SkillSet.create!(
            interview_type_id: interview_type.id,
            skill_id: skill.id
          )
        end
      end
    end
  end
end




