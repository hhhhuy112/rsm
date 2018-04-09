namespace :company_data do
  desc "Auto generate code user data"
  task generate_code_user_data: :environment do
    User.all.each do |user|
      user.update_attributes code: "#{Settings.code.text}#{user.id}"
    end
  end
end
