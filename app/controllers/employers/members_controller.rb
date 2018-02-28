class Employers::MembersController < Employers::EmployersController
  before_action :get_values_checked, only: :index
  before_action :load_members, only: :index

  def index
    @page = params[:page]
    @users = User.of_company(@company.id).not_role(User.roles[:admin]).
      not_member.search_name_or_mail(params[:search])
    respond_to do |format|
      format.html
      format.js
    end
  end

  def create
    user_ids = params[:member][:user_ids]
    user_roles = params[:member][:user_roles]
    members = []
    user_ids.each_with_index do |id, i|
      next if id.blank?
      members << Member.new(position: "employee", start_time: Date.current,
        company_id: params[:company_id], user_id: id, role: user_roles[i])
    end
    if Member.import members
      flash[:success] = t ".add_member_complete"
    else
      flash[:danger] = t ".can_not_add_member"
    end
    if request.xhr?
      render js: "window.location = '#{employers_members_path}'"
    else
      redirect_to employers_members_path
    end
  end

  def update
    respond_to do |format|
      if @member.update_attributes member_params
        format.js{@message = t ".update_success"}
      else
        format.js{@message = t ".update_fail"}
      end
    end
    load_members
  end

  def destroy
    if @member.destroy
      @message = t ".success"
    else
      @error = t ".failure"
    end
  end

  private

  def get_values_checked
    @member_checkeds = if params[:checked_values].present?
      params[:checked_values].strip.split(',')
    else
      []
    end
  end

  def member_params
    params.require(:member).permit :position, :start_time, :end_time, :role
  end

  def load_members
    @members = @company.members.sort_by_updated.page(params[:page]).per Settings.apply.page
  end
end
