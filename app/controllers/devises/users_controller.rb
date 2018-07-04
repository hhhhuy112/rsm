class Devises::UsersController < Devise::RegistrationsController
  before_action :load_company

  def edit
    super
  end

  def update
    super
  end

  protected

  def after_update_path_for resource
    user_path resource
  end
end
