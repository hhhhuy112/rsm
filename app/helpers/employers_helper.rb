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

  def show_step step
    case
    when step.is_step?(Settings.step.review)
      Settings.warning
    when step.is_step?(Settings.step.test)
      Settings.info
    when step.is_step?(Settings.step.interview)
      Settings.primary
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
    content_tag :span, class: "label label-#{show_status(status_step)} #{status_step.code}" do
      content_tag :b do
        t "employers.applies.statuses.#{status_step.code}"
      end
    end
  end

  def show_step_apply step
    content_tag :span, class: "label label-#{show_step(step)}" do
      content_tag :b do
        t "employers.applies.statuses.#{step.name}"
      end
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

  def status_survey status
    case status
    when Settings.survey.optional
      Settings.warning
    when Settings.survey.compulsory
      Settings.danger
    else
      Settings.success
    end
  end

  def radio_survey_type key, value, f
    content_tag :div, class: "funkyradio-#{status_survey value} col-md-3 m-bottom-10" do
      concat f.radio_button :survey_type, value, id:"radio#{value}"
      concat f.label :survey_type, t("survey.#{key}"), for: "radio#{value}"
    end
  end

  def view_template_body
    t("employers.templates.show.content_template").html_safe
  end

  def is_show_resend? current_apply_status, data_step
    if data_step[:is_current_step]
      current_apply_status.id == data_step[:apply_status_lastest].id
    else
      current_apply_status.status_step.is_status? Settings.pending
    end
  end

  def disabled_block apply
    return "overcast-div" if apply.lock_apply?
  end

  def is_offer_status_pending
    @company.steps.last.id == @current_step.id && @offer_status_pending_id.last < @apply_status.status_step_id
  end
end
