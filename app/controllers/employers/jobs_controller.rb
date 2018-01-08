class Employers::JobsController < Employers::EmployersController
  before_action :create_job, only: %i(index new)
  before_action :load_jobs, only: :index
  before_action :load_members, :load_templates, only: :show

  def show
    @appointment = @company.appointments.build
    @applies = @job.applies.page(params[:page]).per Settings.apply.page
  end

  def create
    respond_to do |format|
      if @job.save
        format.js{ @message = t "job_created"}
      else
        format.js
      end
    end
    load_jobs
  end

  def index
    @page = params[:page]
  end

  def destroy
    respond_to do |format|
      if @job.destroy
        format.js{@message = t "deleted_job"}
      else
        format.js
      end
    end
  end

  def edit; end

  def update
    respond_to do |format|
      if @job.update_attributes job_params
        format.js{@message = t "job_updated"}
      else
        format.js
      end
    end
    load_jobs
  end

  private

  def create_job
    @job = @company.jobs.new user_id: current_user.id
  end

  def job_params
    params.require(:job).permit(:content, :name, :level, :language,
      :skill, :position, :company_id, :description, :min_salary, :max_salary,
      :branch_id, :category_id, reward_benefits_attributes: %i(id content job_id _destroy))
      .merge!(user_id: current_user.id)
  end

  def load_jobs
    @jobs = @company.jobs.sort_lastest.page(params[:page]).per Settings.job.page
  end
end
