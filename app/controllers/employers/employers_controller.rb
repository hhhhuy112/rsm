class Employers::EmployersController < ApplicationController
  layout "employers/employer"

  before_action :authenticate_user!
  before_action :current_ability
  load_and_authorize_resource
  before_action :load_company

  private

  def load_company
    @company = current_user.companies.last
    return if @company
    flash[:danger] = t "can_not_find_company"
    redirect_to root_path
  end
end
