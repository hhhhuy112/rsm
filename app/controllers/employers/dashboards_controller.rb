class Employers::DashboardsController < BaseNotificationsController
  layout "employers/employer"

  before_action :authenticate_user!
  before_action :load_company
  before_action :load_search_form
  before_action :check_permissions_employer
  before_action :current_ability
  before_action :load_notifications

  def index
    check_params if request.xhr?
    @support_dashboard = Supports::Dashboard.new(@company, params[:q], @company.apply_statuses)
  end

  private

  def check_permissions_employer
    return if current_user.is_employer_of? @company.id
    flash[:danger] = t "company_mailer.fail"
    redirect_to root_url
  end

  def check_params
    if params[:q].present? && params[:q][:created_at_gteq].present? &&
      params[:q][:created_at_lteq].present? && params[:q][:created_at_lteq].to_date &&
      params[:q][:created_at_gteq].to_date && params[:q][:created_at_gteq].to_date >
      params[:q][:created_at_lteq].to_date
        @message = t ".error"
    end
  end
end
