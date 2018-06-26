class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_locale
  before_action :rack_mini_profiler_authorize_request
  helper_method :file_path, :get_setting_content_type
  before_action :store_user_location!, if: :storable_location?

  rescue_from ActiveRecord::RecordNotFound do |exception|
    @error_message = exception.model
    respond_to do |format|
      format.js{render "errors/error", status: 401}
      format.html{redirect_to redirect_to_path, alert: @error_message}
    end
  end

  rescue_from CanCan::AccessDenied do |exception|
    flash[:danger] = I18n.t "company_mailer.fail"
    redirect_to main_app.root_url
  end

  def file_path email_google, content_type = Settings.email_google.type.pdf
    extension_file = get_setting_content_type content_type
    email_from = @email_google.from.first.mailbox + @email_google.from.first.host
    "opt/cv/#{email_from}/cv.#{extension_file.first}"
  end

  def get_setting_content_type content_type
    content_type_file = content_type.split(";")[0]
    Settings.email_google.type.find do |key, value|
      content_type_file.eql? value
    end
  end

  protected

  def load_service
    @google_client_service = GoogleClientService.new current_user
  end

  def load_company
    @company = Company.find_by subdomain: request.subdomain
    return if @company.present?
    redirect_root_path
  end

  def load_branches
    @branches = @company.branches.by_status(Branch.statuses[:active]).order_is_head_office_and_province_desc
  end

  def redirect_root_path
    if request.subdomain != Settings.www
      flash[:danger] = t "can_not_find_company"
      redirect_to root_url(subdomain: false)
    end
  end

  def current_ability
    controller_name_segments = params[:controller].split("/")
    controller_name_segments.pop
    controller_namespace = controller_name_segments.join("/").camelize
    apply = Apply.find_by id: params[:apply_id]
    Ability.new(current_user, controller_namespace, apply)
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i(name phone address sex birthday company_id skip_cv_validation password password_confirmation))
    devise_parameter_sanitizer.permit(:account_update, keys: %i(name phone address sex birthday company_id skip_cv_validation))
  end

  def load_oauth
    @oauth = current_user.oauth
    return if @oauth
    @disconnect_gmail = t "oauth.google.disconnect_gmail"
  end

  def load_activities_apply
    return if @apply.blank?
    @apply_activities = Activity.get_by_apply(@apply.id).includes(
      :trackable, :owner).page params[:page]
    Activity.preload @apply_activities
  end

  def authenticate_user!
    if user_signed_in?
      super
    else
      session[Settings.sessions.user_return_to] = request.url
      redirect_to root_path(require_login: true), notice: t("devise.failure.unauthenticated")
    end
  end

  private

  def set_locale
    I18n.locale = session[:locale] || I18n.default_locale
    session[:locale] = I18n.locale
  end

  def rack_mini_profiler_authorize_request
    environments = Rails.application.config.rack_mini_profiler_environments
    return unless Rails.env.in? environments
    Rack::MiniProfiler.authorize_request
  end

  protected

  def storable_location?
    request.get? && is_navigational_format? && !devise_controller? && !request.xhr?
  end

  def store_user_location!
    store_location_for(:user, request.fullpath)
  end

  def redirect_to_path
    controller_name_segments = params[:controller].split("/")
    path = if Settings.employers_controllers.include? controller_name_segments.pop
      employers_dashboards_path
    else
      root_path
    end
  end
end

