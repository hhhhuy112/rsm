class ClubsController < ApplicationController
  before_action :authenticate_user!
  before_action :current_ability
  load_and_authorize_resource param_method: :params_club
  before_action :load_clubs, only: :destroy

  def create
    respond_to do |format|
      if @club.save
        format.js{@message = t "clubs.create_success"}
      else
        format.js
      end
    end
  end

  def update
    respond_to do |format|
      if @club.update_attributes params_club
        format.js{@message = t "clubs.update_success"}
      else
        format.js
      end
    end
  end

  def destroy
    respond_to do |format|
      if @club.destroy
        format.js{@success = t "clubs.destroy_success"}
      else
        format.js{@fail = t "clubs.destroy_fail"}
      end
    end
  end

  private

  def load_clubs
    @clubs = current_user.clubs
  end

  def params_club
    params.require(:club).permit :name, :content, :current, :start_time, :end_time,
      :position
  end
end
