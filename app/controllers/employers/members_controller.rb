class Employers::MembersController < Employers::EmployersController
  before_action :current_ability

  def index
    @members = @company.members.page(params[:page]).per(Settings.apply.page)
  end
end
