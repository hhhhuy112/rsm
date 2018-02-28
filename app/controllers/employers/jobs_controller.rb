class Employers::JobsController < Employers::EmployersController
  before_action :create_job, only: %i(index new)
  before_action :load_jobs, only: :index
  before_action :load_branches_for_select_box, only: :index
  before_action :load_category_for_select_box, only: :index
  before_action :load_questions, :build_surveys, only: :new
  before_action :check_params, :convert_params_questions, only: :create
  before_action :load_status_step, only: %i(index update)

  def show
    @applies = @job.applies.includes(:user).page(params[:page]).per Settings.apply.page
    @apply_statuses = ApplyStatus.of_apply(@applies.pluck(:id)).includes(:status_step)
      .current.group_by(&:apply_id)
    @page = params[:page]
  end

  def create
    @job = current_user.jobs.build job_params
    @job.self_attr_after_create @question_ids
    respond_to do |format|
      if @job.save
        @status_step = @company.company_steps.priority_lowest
          .last.step.status_steps
        @message = t ".success"
      end
      load_questions
      load_jobs
      format.js
    end
  end

  def index
    @search = @company.jobs.includes(:applies).search params[:q]
    @jobs = @search.result(distinct: true).sort_lastest
      .page(params[:page]).per Settings.job.page
    @page = params[:page]
  end

  def destroy
    respond_to do |format|
      if @job.destroy
        format.js{@message = t "jobs.destroy.job_destroyed"}
      else
        format.js
      end
    end
  end

  def edit; end

  def update
    respond_to do |format|
      if @job.update_attributes job_params
        @message = t ".success"
        format.js
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
    params[:job][:survey_type] = params[:job][:survey_type].to_i if params[:job]
    if params[:expire_on] == Settings.jobs.form.check_box_expire_on
      params.require(:job).permit :content, :name, :level, :language, :target, :end_time, :skill,
        :position, :company_id, :description, :min_salary, :max_salary, :branch_id, :category_id,
        :survey_type, reward_benefits_attributes: %i(id content job_id _destroy),
        surveys_attributes: [:id, :_destroy, question_attributes: %i(name company_id _destroy)]
    else
      params.require(:job).permit(:content, :name, :level, :language, :target, :skill,
        :position, :company_id, :description, :min_salary, :max_salary, :branch_id, :category_id,
        :survey_type, reward_benefits_attributes: %i(id content job_id _destroy),
        surveys_attributes: [:id, :_destroy, question_attributes: %i(name company_id _destroy)])
        .merge! end_time: nil
    end
  end

  def load_jobs
    @jobs = @company.jobs.includes(:applies).sort_lastest.page(params[:page]).per Settings.job.page
  end

  def load_applies_joined_by_jobs
    @applies_by_jobs = @company.applies.joined.group_by &:job_id
  end

  def load_branches_for_select_box
    @provinces ||= @company.branches.by_status(Branch.statuses[:active]).order_is_head_office_and_province_desc.pluck :province, :id
  end

  def load_category_for_select_box
    @categories ||= @company.categories.by_status(Category.statuses[:active]).order_name_desc.pluck :name, :id
  end

  def build_surveys
    @job.surveys.build
  end

  def check_params
    if params[:job] && !params[:onoffswitch]
      params[:job][:survey_type] = Settings.default_value
    end
  end

  def load_status_step
    @status_step = @company.company_steps.priority_lowest.last.step.status_steps
  end

  def load_questions
    @questions = @company.questions.get_newest
  end

  def convert_params_questions
    @question_names = params[:name_question_choosen].split(",") if params[:name_question_choosen].present?
    @question_ids = params[:choosen_ids].split(",") if params[:choosen_ids].present?
  end
end
