namespace :company_data do
  desc "Auto generate recipient activity data"
  task generate_recipient_activity: :environment do
    Activity.all.each do |activity|
      if activity.trackable.kind_of? Apply
        activity.update_attribute :recipient, activity.trackable
      else
        activity.update_attribute :recipient, activity.trackable.apply
      end
    end
  end
end
