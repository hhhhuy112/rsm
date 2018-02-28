class Employers::StatusStepsController < Employers::EmployersController

  before_action :load_status_step, only: :index
  before_action :load_steps, only: :index

  def index
    @q = ApplyStatus.current.search params[:q]
    render json: {
      step_current: params[:step_id],
      content: (render_to_string partial: "select_status",
        locals: {status_steps: @status_steps, q: @q, steps: @steps},
        layout: false)}
  end

  private

  def load_status_step
    if params[:step_id].blank?
      load_statuses
    else
      @status_steps = StatusStep.search_step params[:step_id]
      return if @status_steps
      render json: {error: t(".status_nil")}
    end
  end
end
