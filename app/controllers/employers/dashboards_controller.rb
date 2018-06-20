class Employers::DashboardsController < Employers::EmployersController
  layout "employers/employer"

  def index
    check_params if request.xhr?
    @support_dashboard = Supports::Dashboard.new(@company, params[:q], @company.apply_statuses)
  end

  private

  def check_params
    if params[:q].present? && params[:q][:created_at_gteq].present? &&
      params[:q][:created_at_lteq].present? && params[:q][:created_at_lteq].to_date &&
      params[:q][:created_at_gteq].to_date && params[:q][:created_at_gteq].to_date >
      params[:q][:created_at_lteq].to_date
        @message = t ".error"
    end
  end
end
