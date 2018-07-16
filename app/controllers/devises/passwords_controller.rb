class Devises::PasswordsController < Devise::PasswordsController
  before_action :load_company

  def new
    super
  end

  def update
    self.resource = resource_class.reset_password_by_token(resource_params)
    yield resource if block_given?

    if resource.errors.empty?
      resource.unlock_access! if unlockable?(resource)
      if Devise.sign_in_after_reset_password
        flash_message = resource.active_for_authentication? ? :updated : :updated_not_active
        set_flash_message!(:notice, flash_message)
        sign_in(resource_name, resource)
      else
        set_flash_message!(:notice, :updated_not_active)
      end
      respond_with resource, location: after_resetting_password_path_for(resource)
    else
      show_flash_reset_token resource
      set_minimum_password_length
      respond_with resource
    end
  end

  def create
    if request.xhr?
      resource = resource_class.send_reset_password_instructions resource_params
      if successfully_sent? resource
        render json: {success: true, message: t("devise.passwords.send_instructions")}
      else
        render json: {success: false, message: resource.errors.full_messages}
      end
    else
      super
    end
  end

  private

  def show_flash_reset_token resource
    return if !resource.errors.include? :reset_password_token
    flash[:error] = resource.errors.full_messages.first
  end

end
