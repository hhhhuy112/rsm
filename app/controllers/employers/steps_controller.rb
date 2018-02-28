class Employers::StepsController < Employers::EmployersController
  before_action :load_apply, :load_apply_status, :load_current_step,
    :load_history_apply_status, :load_status_step_scheduled

  def show
    respond_to do |format|
      format.js
    end
  end

  private

  def load_history_apply_status
    step_service = StepService.new @step, @apply, @company, @current_step, @apply_status_step
    if params[:status_step_id].present?
      @apply_status = @apply_status_step.present? ? @apply_status_step : build_apply_status
      @status_step = step_service.status_step_lastest
      @status_steps = step_service.step.status_steps
      @data_step = @apply_status_step.present? ? step_service.get_data_step : load_data_step(step_service)
    else
      @apply_status = step_service.apply_status_lastest
      @status_step = step_service.status_step_lastest
      @status_steps = step_service.step.status_steps
      @data_step = step_service.get_data_step
    end

  end

  def load_apply_status
    @apply_status_step = @apply.apply_statuses.find_by status_step_id: params[:status_step_id]
  end

  def load_data_step step_service
    {
      is_prev_step: step_service.is_prev_step,
      apply_status_lastest: @apply_status,
      status_step_lastest: @apply_status.status_step,
      company_step: @company_step,
      appointment: @appointment,
      email_sents: @email_sents
    }
  end

  def build_apply_status
    @apply.apply_statuses.build status_step_id: params[:status_step_id]
  end
end
