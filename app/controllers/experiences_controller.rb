class ExperiencesController < ApplicationController
  before_action :authenticate_user!
  before_action :current_ability
  load_and_authorize_resource param_method: :params_experience
  before_action :load_experiences, only: :destroy

  def create
    respond_to do |format|
      if @experience.save
        format.js{@message = t "experiences.create_success"}
      else
        format.js
      end
    end
  end

  def update
    respond_to do |format|
      if @experience.update_attributes params_experience
        format.js{@message = t "experiences.update_success"}
      else
        format.js
      end
    end
  end

  def destroy
    respond_to do |format|
      if @experience.destroy
        format.js{@success = t "experiences.destroy_success"}
      else
        format.js{@fail = t "experiences.destroy_fail"}
      end
    end
  end

  private

  def load_experiences
    @experiences = current_user.experiences
  end

  def params_experience
    params.require(:experience).permit :name, :company, :project_detail,
      :start_time, :end_time
  end
end
