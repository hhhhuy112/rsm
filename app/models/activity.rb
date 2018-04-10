class Activity < PublicActivity::Activity
  scope :get_update_date_apply, -> do
    where(recipient_type: Apply.name)
    .group(:recipient_id)
    .maximum :created_at
  end
  scope :get_by_apply, ->apply_id{where recipient_id: apply_id}
  scope :get_by_trackable, ->type{where trackable_type: type}

  delegate :created_at, to: :trackable, prefix: true, allow_nil: true

  class << self
    def preload activities
      return if activities.blank?
      preloader = ActiveRecord::Associations::Preloader.new
      preloader.preload(activities.select {|activity| activity.trackable_type.eql? ApplyStatus.name}, {trackable: %i(appointment status_step)})
    end
  end
end
