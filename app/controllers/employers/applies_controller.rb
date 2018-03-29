class Employers::AppliesController < Employers::EmployersController
  before_action :load_notify, :readed_notification, :load_templates, only: :show
  before_action :load_notifications, only: %i(show index)
  before_action :get_step_by_company, :load_current_step, :load_next_step,
    :load_prev_step, :build_apply_statuses, :load_status_step_scheduled,
    :load_statuses_by_current_step, :build_next_and_prev_apply_statuses,
    :load_apply_statuses, :load_history_apply_status, only: %i(show update)
  before_action :load_steps, only: :index
  before_action :load_statuses, only: :index
  before_action :load_offer_status_step_pending, only: %i(show update)
  before_action :load_jobs_applied, :load_notes, only: :show
  before_action :load_answers_for_survey, only: :show
  before_action :load_applies, :select_size_steps, only: :index
  before_action :load_user_candidate, only: :create, if: :is_params_candidate?
  before_action :check_create_apply_for_candidate, only: :create
  before_action :load_jobs, only: :new

  def index; end

  def show
    respond_to do |format|
      format.js
      format.html
    end
  end

  def new; end

  def create
    information = params[:apply][:information].permit!.to_h
    job_ids = params[:job_ids]
    import_applies job_ids, information
  end

  def update
    respond_to do |format|
      if @apply.update_columns status: get_status, updated_at: Time.now.getutc
        html_content = render_to_string(partial: "employers/applies/apply_btn",
          locals: {current_step: @current_step, steps: @steps,
          current_apply_status: @current_apply_status, current_status_steps: @current_status_steps})
        format.json{render json: {message: t("employers.applies.block_apply.success"), html_data: html_content}}
      else
        format.json{render json: {message: t("employers.applies.block_apply.fail")}}
      end
      format.html
    end
  end

  private

  def apply_params
    status_id = StatusStep.status_step_priority_company @company.id
    params.require(:apply).permit(:cv, :job_id)
      .merge! apply_statuses_attributes: [status_step_id: status_id, is_current: :current]
  end

  def get_status
    return Apply.statuses["unlock_apply"] if @apply.lock_apply?
    Apply.statuses["lock_apply"]
  end

  def import_applies job_ids, information
    Apply.transaction requires_new: true do
      applies = []
      job_ids.each do |id|
        next if id.blank?
        params[:apply][:job_id] = id
        apply = Apply.new apply_params
        apply.information = information
        apply.cv = @candidate.applies.first.cv if is_params_candidate?
        apply.save!
      end
      @success = t ".success"
      load_applies_after_save
    end
  rescue ActiveRecord::RecordInvalid
    @error = t ".failure_user"
  end

  def load_jobs_applied
    apply_ids = Apply.get_have_job.get_by_user(@apply.user_id).pluck :id
    @apply_statuses_applied = ApplyStatus.current.of_apply(apply_ids).includes :job
  end

  def load_answers_for_survey
    @answers = @apply.answers.name_not_blank
      .page(params[:page]).per Settings.survey.max_record
  end

  def check_create_apply_for_candidate
    respond_to do |format|
      if params[:job_ids] && params[:job_ids][1].blank?
        @error = t ".job_nil"
        format.js {render "employers/applies/create"}
      else
        format.js
        format.html
      end
    end
  end

  def load_applies
    applies_status = @company.apply_statuses.current
    @applies_total = applies_status.size
    @q = applies_status.search params[:q]
    @applies_status = @q.result.lastest_apply_status.includes(:apply, :job, :status_step)
      .page(params[:page]).per Settings.applies_max
  end

  def select_size_steps
    @size_steps = SelectApply.caclulate_applies_step @company
  end

  def is_params_candidate?
    params[:role] == Settings.candidate
  end

  def load_applies_after_save
    if is_params_candidate?
      load_applies_candidate
    else
      load_applies
    end
  end
end
