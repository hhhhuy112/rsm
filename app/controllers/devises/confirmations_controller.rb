class Devises::ConfirmationsController < Devise::ConfirmationsController
  skip_before_action :verify_authenticity_token, only: :create, if: ->{request.xhr?}
  before_action :load_company

  def show
    self.resource = resource_class.confirm_by_token(params[:confirmation_token])
    if resource.errors.empty?
      set_flash_message(:notice, :confirmed) if is_navigational_format?
      sign_in(resource_name, resource)
      respond_with_navigational(resource){ redirect_to after_sign_in_path_for(resource) }
    else
      respond_with_navigational(resource.errors, status: :unprocessable_entity){ render :new }
    end

  end

  def new
    super
  end

  def create
    if request.xhr?
      user = User.find_by email: params[:email]
      if user
        user.send_confirmation_instructions
        message = t "devise.registrations.signed_up_but_unconfirmed"
        render json: {success: true, message: message}
      else
        render json: {success: false, message: t(".not_found")}
      end
    else
      super
    end
  end
end
