class Employers::AppliesController < Employers::EmployersController
  before_action :load_notify, :readed_notification, :load_templates, only: :show
  before_action :load_notifications, only: %i(show index)
  before_action :get_step_by_company, :load_current_step, :load_next_step,
    :load_prev_step, :build_apply_statuses, :load_status_step_scheduled,
    :load_statuses_by_current_step, :build_next_and_prev_apply_statuses,
    :load_apply_statuses, :load_history_apply_status, :load_activities_apply, only: %i(show update)
  before_action :load_steps, only: :index
  before_action :load_statuses, only: :index
  before_action :load_offer_status_step_pending, only: %i(show update)
  before_action :load_jobs_applied, :load_notes, only: :show
  before_action :load_answers_for_survey, only: :show
  before_action :value_email_of_info_or_code, :load_applies, :select_size_steps, :get_update_date_apply, only: :index
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
    job_ids = params[:choosen_ids].split(",")
    import_applies job_ids, information
  rescue ActiveRecord::RecordNotUnique
    @error = t ".duplicate_apply", email: information[:email]
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
    return @error = t(".job_nil") if job_ids.blank?
    Apply.transaction requires_new: true do
      applies = []
      job_ids.each do |id|
        next if id.blank?
        params[:apply][:job_id] = id
        apply = Apply.new apply_params
        apply.information = information
        apply.cv = @candidate.applies.first.cv if is_params_candidate?
        apply.self_attr_after_create current_user
        apply.save!
      end
      @success = t ".success"
      load_applies_after_save information
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
      if params[:choosen_ids].blank?
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

    applies_status_email_or_code = if @email_of_info_or_code.present?
      ApplyStatus.current.of_apply(
        Apply.email_of_information(@email_of_info_or_code).or(Apply.of_cadidate(@company.user_systems.get_by_code(@email_of_info_or_code).pluck(:id)))
        .get_by_job(@company.job_ids)
        .pluck(:id).uniq
      )
    end

    @q = applies_status.search params[:q]
    applies_status = @q.result.lastest_apply_status.includes :apply, :job, :status_step

    search_applies_status applies_status_email_or_code, applies_status

    @applies_status = Kaminari.paginate_array(@applies_status)
      .page(params[:page]).per Settings.applies_max
  end

  def select_size_steps
    @size_steps = SelectApply.caclulate_applies_step @company
  end

  def is_params_candidate?
    params[:role] == Settings.candidate
  end

  def load_candidate information
    applies = Apply.get_by_email information[:email]
    return @error = t(".not_applies") if applies.blank?
    @candidate = applies.first.user
  end

  def load_applies_after_save information
    if is_params_candidate?
      load_applies_candidate
    else
      load_candidate information
    end
  end

  def get_update_date_apply
    @activities = Activity.get_update_date_apply
  end

  def value_email_of_info_or_code
    @email_of_info_or_code = if params[:email_of_info_or_code].present?
      params[:email_of_info_or_code]
    else
      params[:q].present? ? params[:q][:email_of_info_or_code] : nil
    end
  end

  def search_applies_status applies_status_by_email_or_code, applies_status_by_other_condition
    @applies_status = if @email_of_info_or_code.present?
      if applies_status_by_email_or_code.nil? || applies_status_by_other_condition.nil?
        []
      else
        applies_status_by_email_or_code&applies_status_by_other_condition
      end
    else
      applies_status_by_other_condition
    end
  end
end
