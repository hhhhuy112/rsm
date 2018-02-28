class Supports::Dashboard
  attr_reader :company, :params_q

  def initialize company, params_q, apply_status
    @company = company
    @params_q = params_q
    @dashboard = {}
    @count = {}
    @apply_status = apply_status
  end

  def prioritize_jobs
    @company.jobs.includes(:branch).job_company(@company).sort_max_salary_and_target
  end

  def prioritize_apply_statues
    @company.apply_statuses.current.sort_apply_statues.includes(:job, :status_step)
  end

  def total_apply_statuses
    @apply_status.current.size
  end

  def params_q
    @apply_status.current.search @params_q
  end

  def dashboard_apply
    @company.steps.each do |step|
      @dashboard[step.name] = Settings.dashboard.zero
    end
    params_q.result(distinct: true).includes(:step).group_by(&:step).each do |f|
      @dashboard[f.first.name] = f.second.size
    end
    @dashboard
  end

  def count_apply
    dashboard_apply.each do |key, value|
      @count[I18n.t("employers.dashboards.list_statistic.#{key}")] = value
    end
    @count
  end
end
