module AppliesHelper
  def get_data appointments, apply
    content_tag "div", "", id: "apply-appointments", data: {events: appointments, name: get_name_to(apply)}
  end

  def get_name_to apply
    apply.information[:name] || ''
  end

  def cv_update_at user
    "(#{t ".update"} #{l current_user.updated_at, format: :date_time})"
  end

  def get_update_date apply_id, activities
    return if activities.blank?
    date = activities[apply_id]
    l(date, format: :short) if date
  end
end
