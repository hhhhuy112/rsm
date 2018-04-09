module AppliesHelper
  def get_data appointments, apply
    content_tag "div", "", id: "apply-appointments", data: {events: appointments, name: get_name_to(apply)}
  end

  def get_name_to apply
    apply && apply.information[:name] && apply.job_name ? "#{apply.information[:name]} - #{apply.job_name}" : ''
  end

  def cv_update_at user
    "(#{t ".update"} #{l current_user.updated_at, format: :date_time})"
  end

  def get_update_date apply_id, activities
    return if activities.blank?
    date = activities[apply_id].in_time_zone(File.read("/etc/timezone").chomp)
    l(date, format: :date_time) if date
  end

  def show_time_appointment_by_local appointment_builder, key
    if appointment_builder.object.new_record? && appointment_builder.object.send(key)
      appointment_builder.text_field key, value: show_date_time_local(ActiveSupport::TimeZone
        .new(File.read("/etc/timezone").chomp).local_to_utc(appointment_builder.object.send(key))),
        class: "form-control edit-control apply-appointment-#{key}", readonly: true
    else
      appointment_builder.text_field key, value: show_date_time_local(appointment_builder
        .object.send(key)), class: "form-control edit-control apply-appointment-#{key}",
        readonly: true
    end
  end
end
