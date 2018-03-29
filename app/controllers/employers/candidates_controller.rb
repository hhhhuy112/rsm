class Employers::CandidatesController < Employers::EmployersController
  authorize_resource class: false
  before_action :load_user_candidate, only: %i(new show)
  before_action :load_applies_candidate, only: :show
  before_action :build_candidate, only: %i(index new)
  before_action :load_candidates, only: :index
  before_action :check_candidate_exist, only: :create
  before_action :load_job_applied_candidate, only: :new

  def index; end

  def show; end

  def new; end

  def create
    information = params[:apply][:information].permit!.to_h if params[:apply]
    save_apply information
  end

  def search_job
    if params[:is_candidate]
      load_user_candidate
      load_job_applied_candidate
    else
      load_jobs
    end
  end

  private

  def build_candidate
    @apply = Apply.new
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
    user_ids = User.get_company(@company.id).pluck :id
    candidate_ids = Apply.get_by_user(user_ids).pluck(:user_id).uniq
    @q_candidates = User.get_by_id(candidate_ids).search params[:q]
    @candidates = @q_candidates.result.newest.page(params[:page]).per Settings.apply.page
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
end
