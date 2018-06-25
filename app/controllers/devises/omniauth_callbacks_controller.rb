class Devises::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  before_action :load_user, only: %i(facebook linkedin framgia)
  before_action :load_company


  def framgia
    sign_in_social Settings.omniauth.framgia
  end

  def google_oauth2
    if current_user
      save_oauth request.env["omniauth.auth"]
      redirect_after_save_oauth request.env["omniauth.params"]
    else
      load_user
      sign_in_social Settings.omniauth.google_oauth2
    end
  end

  def facebook
    sign_in_social Settings.omniauth.facebook
  end

  def linkedin
    sign_in_social Settings.omniauth.linkedin
  end

  private

  def save_oauth auth
    if current_user.email == auth.info.email
      if current_user.oauth
        flash[:danger] = t "devise.omniauth_callbacks.account_connected"
      else
        oauth = Oauth.new user_id: current_user.id, token: auth.credentials.token,
          expires_at: Time.at(auth.credentials.expires_at),
          refresh_token: auth.credentials.refresh_token
        if oauth.save
          flash[:success] = t "devise.omniauth_callbacks.connect_gmail"
        else
          flash[:danger] = t "devise.omniauth_callbacks.connect_gmail_failure"
        end
      end
    else
      flash[:danger] = t "devise.omniauth_callbacks.account_invalid"
    end
  end

  def redirect_after_save_oauth request
    if request && request["apply_id"] && request["job_id"]
      apply = Apply.find_by id: request["apply_id"]
      if apply
        redirect_to employers_job_apply_url job_id: request["job_id"].to_i,
          id: request["apply_id"].to_i
        return
      end
    end
    redirect_to employers_dashboards_url
  end

  def load_user
    @user = User.find_by email: request.env["omniauth.auth"].info.email
  end

  def new_user data, provider
    @user = User.new email: data.email, name: data.name,
      password: Devise.friendly_token.first(Settings.password.length),
      company_id: @company.id, skip_cv_validation: true
    return if provider.blank? || (provider != Settings.omniauth.facebook && provider != Settings.omniauth.framgia)

    if provider == Settings.omniauth.facebook
      @user.remote_picture_url = data.image.gsub("http://", "https://") if data.image.present?
    end

    return if provider != Settings.omniauth.framgia
    @user.remote_picture_url = data.avatar.gsub("http://", "https://") if data.avatar.present?
    @user.birthday = data.birthday
    @user.code = data.employee_code
    @user.birthday = data.birthday
  end

  def sign_in_social provider
    if @company
      if @user && @user.persisted?
        sign_in @user
        flash[:success] = t "devise.omniauth_callbacks.success",
          kind: provider
      else
        new_user request.env["omniauth.auth"].info, provider
        @user.skip_confirmation!
        if @user.save
          sign_in @user
          flash[:success] = t "devise.omniauth_callbacks.success",
            kind: provider
        else
          flash[:danger] = t "devise.omniauth_callbacks.failure",
            kind: provider
        end
      end
    else
      flash[:danger] = t "devise.omniauth_callbacks.not_company"
    end
    redirect_to root_url
  end

  def load_company
    @company = Company.find_by subdomain: request.env["SERVER_NAME"].split(".").first
  end
end
