class Employers::EvaluationsController < Employers::EmployersController
  before_action :find_apply, only: %i(new create show)
  before_action :interviewed!, only: %i(new create)
  before_action :load_interview_type, only: :new
  before_action :build_evaluation, only: :new
  load_and_authorize_resource
  before_action :check_evaluation_of_apply, only: :show
  before_action :build_knowledges, only: :new
  before_action :load_current_step, only: %i(new show)
  before_action :load_statuses_by_current_step, only: %i(new show)
  before_action :load_applies_status, :get_update_date_apply, only: :index

  def index; end

  def show; end

  def new
    respond_to do |format|
      format.html
      format.js
    end
  end

  def create
    @evaluation = Evaluation.new evaluation_params
    if @evaluation.save
      @evaluation.save_activity :create, current_user
      Notification.create_notification :user, @apply,
        current_user, @apply.job.company_id, @apply.user_id if @apply.user_id
      flash[:success] = t "employers.evaluations.create_success"
      redirect_to employers_interviews_path
    else
      load_current_step
      flash.now[:danger] = t "employers.evaluations.create_fail"
      render :new
    end
  end

  private

  def find_apply
    @apply = Apply.find_by id: params[:apply_id]
    return if @apply
    flash[:danger] = t "applies.apply_not_found"
    redirect_to employers_applies_path unless request.xhr?
    render js: "window.location = '#{employers_dashboards_path}'"
  end

  def evaluation_params
    params.require(:evaluation).permit(:other, :apply_id, :interview_type_id, :_destroy,
      knowledges_attributes: [:id ,:score, :writing_evaluation, :skill_id, :note,
      skill_attributes: [:id, :company_id, :name, :type_skill,
      skill_sets_attributes: [:interview_type_id, :skill_id]]])
  end

  def load_interview_type
    return @interview_type = InterviewType.first if params[:interview_type_id].blank?
    @interview_type = InterviewType.find_by id: params[:interview_type_id]
    return if @interview_type
    error_message = t ".not_found", error_message: InterviewType.name
    if request.xhr?
      render js: "alertify.success('<%= error_message %>')"
    else
      flash[:danger] = error_message
      redirect_to employers_interviews_path
    end
  end

  def build_knowledges
    @interview_type.skills.each do |skill|
      @evaluation.knowledges.build skill_id: skill.id
    end
  end

  def interviewed!
    return if @apply.evaluation.blank?
    redirect_to employers_apply_evaluation_path(@apply, @apply.evaluation) unless request.xhr?
    render js: "window.location = '#{employers_apply_evaluation_path(@apply, @apply.evaluation)}'"
  end

  def check_evaluation_of_apply
    return if @apply.evaluation == @evaluation
    flash[:danger] = t "evaluations.evaluation_not_found"
    redirect_to employers_interviews_path
  end

  def load_applies_status
    evaluations = current_user.inforappointments.blank? ? @company.evaluations : current_user.evaluations
    @applies_status = @company.apply_statuses.current
      .includes(:apply, :step, :status_step, :evaluation, :job)
      .of_apply(Evaluation.apply_ids evaluations)
      .page(params[:page]).per Settings.applies_max
  end

  def get_update_date_apply
    @activities = Activity.get_update_date_apply
  end

  def build_evaluation
    @evaluation = @apply.build_evaluation interview_type_id: @interview_type.id
  end
end
