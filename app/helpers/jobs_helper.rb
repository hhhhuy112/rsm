module JobsHelper
  def display_company_banner company
    image_tag(company.banner.url) if company.banner.url.present?
  end

  def information_job job, commany
    job.max_salary.present? ? content_share_job(job, commany, salary_job(job.max_salary)):
      content_share_job(job, commany, salary_job(job.min_salary))
  end

  def salary_job job_salary
    job_salary.round.to_s + Settings.currency.dollar
  end

  def content_share_job job, commany, salary
    [t("recruit", company: commany.name), "\n"+ job.name, "\n"+
      t("jobs.show.salary") + salary]
  end

  def options_position_types
    Job.position_types.map { |k,v| [t(".#{k}"), v ] }
  end

  def options_of_selectbox options, param_q, field_search
    value_selected = param_q.present? ? param_q[field_search] : ""
    options_for_select options, value_selected
  end

  def address_of_branch branch
    address = branch.street
    address.concat(", #{branch.ward}") if branch.ward.present?
    address.concat(", #{branch.district}") if branch.district.present?
    address.concat(", #{branch.province}") if branch.province.present?
    address.concat(", #{branch.country}") if branch.country.present?
    address.squish
  end

  def count_applies applies
    applies.blank? ? Settings.default_size : applies.size
  end

  def class_dashboard job, status_step
    case load_value_job job, status_step
    when Settings.job.sixty..Settings.job.hundred
      "success"
    when Settings.job.fourty..Settings.job.sixteen
      "info"
    when Settings.job.twenty..Settings.job.fourteen
      "warning"
    when Settings.job.one..Settings.job.nineteem
      "danger"
    else
      "w10-cl"
    end
  end

  def load_value job
    applies_joined_count = @applies_by_jobs["#{job.id}"].present? ?
      @applies_by_jobs["#{job.id}"].size : 0
    (applies_joined_count/(job.target.to_f)*Settings.job.hundred).to_i
  end

  def count_page counter, page
    counter + CouterIndex.couter(@page, Settings.job.page)
  end

  def check_member? company
    current_user.is_member_of? company.id
  end

  def dashboard_css job, status_step
    if (load_value_job job, status_step) < Settings.job.width
      Settings.job.width
    else
      load_value_job job, status_step
    end
  end

  def load_value_job job, status_step
    @count_id = status_step.last.is_status?(Settings.status_apply.joined) ?
      status_step.get_status(Settings.status_apply.joined).last.id :
      status_step.get_status(Settings.status_apply.interview_passed).last.id
    ((job.apply_statuses.current.is_step(@count_id).size)/(job.target.to_f)*Settings.job.hundred).to_i
  end

  def check_expire_job end_time
    Time.zone.now.to_date > end_time
  end
end
