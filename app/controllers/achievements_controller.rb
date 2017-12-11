class AchievementsController < ApplicationController
  before_action :authenticate_user!
  before_action :current_ability
  load_and_authorize_resource param_method: :params_achievement
  before_action :load_achievements , only: :destroy


  def create
    respond_to do |format|
      if @achievement.save
        format.js{@message = t "achievements.create_success"}
      else
        format.js
      end
    end
  end

  def update
    respond_to do |format|
      if @achievement.update_attributes params_achievement
        format.js{@message = t "achievements.update_success"}
      else
        format.js
      end
    end
  end

  def destroy
    respond_to do |format|
      if @achievement.destroy
        format.js{@success = t "achievements.destroy_success"}
      else
        format.js{@fail = t "achievements.destroy_fail"}
      end
    end
  end

  private

  def load_achievements
    @achievements = current_user.achievements
  end

  def params_achievement
    params.require(:achievement).permit :name, :majors, :organization, :received_time
  end
end
