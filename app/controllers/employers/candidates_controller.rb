class Employers::CandidatesController < Employers::EmployersController
  before_action :load_user_candidate, only: %i(show edit update)
  before_action :load_applies_candidate, only: :show
  before_action :load_candidates, only: :index
  before_action :check_candidate_exist, :auto_value_for_create, only: :create

  def index; end

  def show; end

  def new
    @url_content = params[:url]
    @candidate = User.new
  end

  def create
    if params.require(:user)[:cv].blank? && params[:url].present?
      @candidate.cv = Pathname.new(params[:url]).open
    end
    if @candidate.save
      load_candidates
      @success = t ".success"
    else
      @error_record_invalid = t ".failure"
    end
  end

  def search_job
    if params[:is_candidate]
      load_user_candidate
      load_job_applied_candidate
    else
      load_jobs
    end
  end

  def edit; end

  def update
    if @candidate.update_attributes candidate_param
      load_candidates
      @success = t ".success"
    else
      @error_record_invalid = t ".failure"
    end
  end

  private

  def candidate_param
    params.require(:user).permit :name, :phone, :email, :cv
  end

  def build_candidate
    @candidate = User.new
  end

  def apply_params
    params.require(:apply).permit :cv
  end

  def save_apply information
    @apply = Apply.new apply_params
    @apply.information = information
    @apply.self_attr_after_create current_user
    if @apply.save!
      load_candidates
      @success = t ".success"
    end
  rescue ActiveRecord::RecordInvalid
    @error_record_invalid = t ".failure"
  end

  def load_candidates
    @q_candidates = User.get_company(@company.id).search params[:q]
    @candidates = @q_candidates.result.includes(:assignment_person).newest.page(params[:page]).per Settings.apply.page
  end

  def check_candidate_exist
    respond_to do |format|
      @email = params[:apply][:information][:email] if params[:apply] && params[:apply][:information]
      if User.is_user_candidate_exist? @email
        @error = t ".candidate_exist"
        format.js {render "employers/candidates/create"}
      else
        format.js
        format.html
      end
    end
  end

  def load_job_applied_candidate
    job_ids = @candidate.applies.pluck :job_id
    @q = @company.jobs.get_by_not_id(job_ids).search params[:q]
    @jobs = @q.result.page(params[:page]).per Settings.apply.page
  end

  def auto_value_for_create
    password = Devise.friendly_token.first Settings.password.length
    @candidate = User.new candidate_param
    @candidate.password = @candidate.self_attr_after_save password
    @candidate.role = User.roles[:user]
    @candidate.company_id = @company.id
    @candidate.create_by = @current_user.id
  end
end
