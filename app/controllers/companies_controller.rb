class CompaniesController < BaseNotificationsController
  layout "companies/company"

  before_action :authenticate_user!, only: %i(update edit destroy)
  before_action :current_ability
  load_and_authorize_resource
  before_action :load_company, only: %i(edit update show)
  before_action :load_branches, only: %i(edit update show)
  before_action :load_partners, only: %i(edit update show)
  before_action :load_activities, only: %i(edit update show)
  before_action :load_notifications,only: :show

  def show; end

  def edit; end

  def update
    if @company.update_attributes company_params
      flash[:success] = t "companies.update_success"
    else
      flash[:danger] = t "companies.update_fail"
    end
    redirect_to company_path
  end

  private

  def company_params
    params.require(:company).permit :name, :address, :majors, :contact_person,
      :phone, :company_info, :banner, :logo
  end

  def load_partners
    @partners = @company.partners
  end

  def load_activities
    @activities = @company.company_activities
  end
end
