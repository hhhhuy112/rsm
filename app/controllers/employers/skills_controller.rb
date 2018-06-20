class Employers::SkillsController < Employers::EmployersController
  before_action :load_notifications, only: :index
  before_action :load_skills, only: :index

  def index; end

  private

  def load_skills
    @skills = @company.skills.page(params[:page]).per Settings.skills.page
  end
end
