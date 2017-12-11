class AppliesController < ApplicationController
  load_and_authorize_resource param_method: :apply_params

  def index
    @applies = current_user.applies.includes(:job, :company).newest_apply.
      page(params[:page]).per(Settings.apply.page)
  end

  def show; end

  def create
    respond_to do |format|
      if @apply.save
        format.js{flash.now[:success] = t "apply.applied"}
      else
        format.js
      end
    end
  end

  private

  def apply_params
    params.require(:apply).permit :status, :user_id, :job_id
  end
end
