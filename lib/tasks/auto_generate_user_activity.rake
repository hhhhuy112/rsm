namespace :company_data do
  desc "Auto generate user activity data"
  task generate_user_activity_data: :environment do
    activities = Activity.get_by_trackable Apply.name
    activities.each do |activity|
      activity.update_attributes owner: activity.trackable&.user
    end
  end
end
