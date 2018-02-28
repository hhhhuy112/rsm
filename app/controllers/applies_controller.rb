class AppliesController < ApplicationController
  before_action :load_job, only: :create
  load_and_authorize_resource param_method: :apply_params

  def index
    respond_to do |format|
      @q = current_user.applies.includes(:job, :company).ransack params[:q]
      @applies = @q.result(distinct: true).newest_apply.page(params[:page]).per(Settings.apply.page).to_a.uniq
      format.js
    end
  end

  def show; end

  def create
    respond_to do |format|
      unless @error
        if user_signed_in? && current_user.cv.present?
          @apply.cv = current_user.cv if params[:radio] == Settings.apply.checked
        end
        @apply.information = params[:apply][:information].permit!.to_h if params[:apply]
        save_apply
      end
      format.js
    end
  end

  def update
    respond_to do |format|
      if @apply.update_attribute :status, params[:apply][:status]
        @success = t ".success"
      else
        @error =  t ".error"
      end
      format.js
    end
  end

  private

  def apply_params
    status_id = StatusStep.status_step_priority_company @job.company_id if @job
    params.require(:apply).permit(:status, :user_id, :job_id, :information, :cv,
      answers_attributes: %i(id name survey_id))
      .merge! apply_statuses_attributes: [status_step_id: status_id, is_current: :current]
  end

  def load_job
    @job = Job.find_by id: params[:apply][:job_id] if params[:apply]
    return if @job
    @error = t ".job_nil"
  end

  def save_apply
    @apply.self_attr_after_create current_user, :employer
    if @apply.save
      @success = t "apply.applied"
    elsif !@job.not_exist?
      @questions = @job.questions
    end
  end
end
