class Employers::InterviewsController < Employers::EmployersController
  before_action :load_applies, :get_update_date_apply, only: :index

  def index; end

  private

  def load_applies
    @applies_status = @company.apply_statuses.current
      .includes(:apply, :step, :status_step, :evaluation, :job)
      .interviews_scheduled_by(Inforappointment.appointment_ids current_user.inforappointments)
      .page(params[:page]).per Settings.applies_max
  end

  def get_update_date_apply
    @activities = Activity.get_update_date_apply
  end
end
