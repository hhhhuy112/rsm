class Devises::SessionsController < Devise::SessionsController
  layout "devise_users/devise_user"
  before_action :load_company

  def create
    if request.xhr?
      @user = User.find_by email: params[:user][:email], company_id: @company.id
      if @user && @user.company_id == @company.id
        sign_in_user
      else
        failure
      end
    else
      super
    end
  end

  def failure
    message = t("devise.failure.invalid", authentication_keys: "email")
    render json: {success: false, message: message}
  end

  private

  def sign_in_user
    if @user.valid_password?(params[:user][:password])
      if is_user_active?
        set_flash_message! :notice, :signed_in
        sign_in resource_name, @user
        render json: {success: true, link_redirect: after_sign_in_path_for(@user)}
      else
        render json: {success: false, message: t("devise.failure.not_active",
          link: view_context.link_to(t("here"), "#", id: "resend-confirmation",
          data: {"user-email": params[:user][:email]}))}
      end
    else
      failure
    end
  end

  def after_sign_in_path_for resource
    request.referer || root_path
  end

  def after_sign_out_path_for resource
    request.referer || root_path
  end

  def is_user_active?
    @user.confirmed_at
  end
end
