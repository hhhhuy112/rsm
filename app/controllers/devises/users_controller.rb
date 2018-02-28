class Devises::UsersController < Devise::RegistrationsController
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
