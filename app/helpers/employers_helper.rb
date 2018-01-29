module EmployersHelper

  def show_status status_step
    case
    when status_step.is_status?(Settings.pending)
      Settings.warning
    when status_step.is_status?(Settings.scheduled) || status_step.is_status?(Settings.sent)
      Settings.info
    when status_step.is_status?(Settings.not_selected) || status_step.is_status?(Settings.decline)
      Settings.danger
    else
      Settings.success
    end
  end

  def show_class_gird status_steps
    return Settings.grid.width_6 if status_steps.blank?
    SelectApply.math_col_grid status_steps.size
  end

  def show_status_apply_job apply_statuses
    return if apply_statuses.blank?
    show_status apply_statuses.first.status_step
  end

  def show_status_apply status_step
    content_tag :span, class: "label label-#{show_status(status_step)}" do
      t "employers.applies.statuses.#{status_step.code}"
    end
  end

  def url_image apply
    apply.user ? apply.user.picture.url : "user_avatar_default.png"
  end

  def show_image_apply apply
    image_tag url_image(apply), class: "img-circle img-avatar"
  end

  def get_status is_interview_scheduled
    is_interview_scheduled ? Apply.statuses.keys[6] : Apply.statuses.keys[3]
  end

  def show_time time
    return if time.blank?
    I18n.l time.to_s.to_datetime, format: :format_datetime
  end

  def filter_object object
    object.id.blank?
  end

  def show_progress_status_apply current_step, step, company_steps_by_step
    current_priority = company_steps_by_step[current_step.id].first.priority
    step_priority = company_steps_by_step[step.id].first.priority
    return Settings.completed if current_priority > step_priority ||
      @current_apply_status.status_step.is_status?(Settings.accepted)
    return if current_priority != step_priority
    return Settings.danger if @current_apply_status.status_step.is_status?(Settings.not_selected) ||
      @current_apply_status.status_step.is_status?(Settings.decline)
    return Settings.warning if @current_apply_status.status_step.is_status?(Settings.pending)
    Settings.active
  end

  def show_value current_step, step
    name = if current_step == step
      @current_apply_status.status_step.code
    else
      step.name
    end
    t "employers.applies.statuses.#{name}"
  end

  def show_class_icon status_step
    case
    when status_step.is_status?(Settings.pending)
      Settings.pending
    when status_step.is_status?(Settings.scheduled)
      Settings.scheduled
    when status_step.is_status?(Settings.not_selected)
      Settings.not_selected
    else
      Settings.accepted
    end
  end

  def show_interviewer inforappointments
    interviewers = inforappointments.map do |inforappointment|
      inforappointment.user_name
    end
    interviewers.present? ? interviewers.join(", ") : t("employers.history.no_one")
  end

  def set_value_datepicker param_q, field_search
    param_q.present? ? param_q[field_search] : ""
  end
end
