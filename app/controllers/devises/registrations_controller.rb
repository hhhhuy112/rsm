class Devises::RegistrationsController < Devise::RegistrationsController
  before_action :load_company

  def edit
    super
  end

  def update
    super
  end

  def create
    if request.xhr?
      build_resource sign_up_params
      if resource.save
        @success = true
        @message = t "devise.registrations.signed_up_but_unconfirmed"
      else
        @success = false
        clean_up_passwords resource
      end
      respond_to do |format|
        format.js
      end
    else
      super
    end
  end

  private

  def after_sign_up_path_for resource
    stored_location_for(resource) || root_url
  end

  def after_sign_up_path_for resource
    root_url
  end
end
