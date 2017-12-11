class Employers::CompaniesController < Employers::EmployersController
  load_and_authorize_resource
  before_action :current_ability

  def index; end
end
