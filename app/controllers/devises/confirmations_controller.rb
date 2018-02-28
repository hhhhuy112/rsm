class Devises::ConfirmationsController < Devise::ConfirmationsController
  skip_before_action :verify_authenticity_token, only: :create, if: ->{request.xhr?}

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
