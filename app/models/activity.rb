class Activity < PublicActivity::Activity
  scope :get_update_date_apply, -> do
    where(recipient_type: Apply.name)
    .group(:recipient_id)
    .maximum :created_at
  end
end
