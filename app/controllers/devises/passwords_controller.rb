class Devises::PasswordsController < Devise::PasswordsController
  def new
    super
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
end
