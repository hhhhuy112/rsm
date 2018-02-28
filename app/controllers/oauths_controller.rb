class OauthsController < ApplicationController
  before_action :load_user

  def create
    begin
      oauth_data = Oauth.from_omniauth(request.env['omniauth.auth'])
      @oauth = @user.build_oauth oauth_data
      @oauth.save!
      flash[:success] = "Welcome, #{@user.name}!"
    rescue
      flash[:warning] = "Error authenticate"
    end
    render :create
  end

  private

  def load_user
    email = request.env['omniauth.auth'][:info][:email]
    @user = User.first
  end
end
