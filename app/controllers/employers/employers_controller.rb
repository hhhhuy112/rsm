class Employers::EmployersController < ApplicationController
  layout "employers/employer"

  before_action :authenticate_user!
  before_action :load_company
  before_action :check_permissions_employer
  before_action :current_ability
  load_and_authorize_resource

  private

  def load_members
    @members = @company.members
  end

<<<<<<< HEAD
<<<<<<< HEAD
=======
>>>>>>> fa774d8... fix status applies 1
  def load_templates
    @template_members = current_user.templates.template_member
    @template_users = current_user.templates.template_user
  end

<<<<<<< HEAD
=======
>>>>>>> bbf4e01... fix status apply
=======
>>>>>>> fa774d8... fix status applies 1
  def check_permissions_employer
    return if current_user.is_employer_of? @company.id
    flash[:danger] = t "company_mailer.fail"
    redirect_to root_url
  end
end
