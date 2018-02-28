class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_locale
  before_action :rack_mini_profiler_authorize_request

  rescue_from ActiveRecord::RecordNotFound do |exception|
    @error_message = exception.model
    respond_to do |f|
      f.js{render "errors/error", status: 401}
    end
  end

  rescue_from CanCan::AccessDenied do |exception|
    @error_message = I18n.t "company_mailer.fail"
    redirect_to main_app.root_url
  end

  protected

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
    Ability.new(current_user, controller_namespace)
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i(name phone address sex birthday company_id))
    devise_parameter_sanitizer.permit(:account_update, keys: %i(name phone address sex birthday company_id))
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
end

