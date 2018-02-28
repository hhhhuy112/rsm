class StepService
  attr_reader :apply_status_lastest, :status_step_lastest,
    :step, :apply_status_current_step, :is_prev_step

  def initialize step, apply, company, step_current, apply_status = nil
    @company = company
    @apply = apply
    @step = step

    @company_steps = get_company_step step
    @company_step = @company_steps[step.id].first
    @company_step_current = @company_steps[step_current.id].first
    @is_prev_step = is_prev_step?
    @status_step_ids = @step.status_steps.pluck(:id)

    @apply_statuses = @apply.apply_statuses.lastest_apply_status.includes(:status_step).is_step @status_step_ids

    @apply_status_lastest = apply_status || @apply_statuses.first
    @status_step_lastest = get_status_step

    @email_sents = get_email_sents
    @appointment = get_appointment
    @offers = get_offers
  end

  def get_data_step
    return {} if @apply_status_lastest.blank?
    {
      is_prev_step: @is_prev_step,
      apply_status_lastest: @apply_status_lastest,
      status_step_lastest: @status_step_lastest,
      company_step: @company_step,
      appointment: @appointment,
      email_sents: @email_sents,
      offers: @offers
    }
  end

  def get_appointment
    return if @apply_status_lastest.blank?
    @apply_status_lastest.appointment
  end

  def get_status_step
    return if @apply_status_lastest.blank?
    @apply_status_lastest.status_step
  end

  def get_email_sents
    return {} if @apply_statuses.blank?
    @apply_status_lastest.email_sents.includes :user
  end

  def get_offers
    return if @apply_status_lastest.blank?
    @apply_status_lastest.offers.get_newest.includes :user
  end

  def get_company_step step
    @company.company_steps.group_by(&:step_id)
  end

  def is_prev_step?
    @company_step.priority < @company_step_current.priority
  end
end
