class Employers::AppointmentsController < ApplicationController
  load_and_authorize_resource param_method: :appointment_params

  def create
    respond_to do |format|
      @apply = @appointment.apply
      if @appointment.save
        load_template_user
        SendEmailUserJob.perform_later(@appointment,@template_user)
        create_inforappointments if params[:states].present?
        format.js{@message = t ".create_success"}
      else
        @template_members = current_user.templates.template_member
        @template_users = current_user.templates.template_user
        @members = @appointment.company.members
        format.js
      end
    end
  end

  private

  def appointment_params
    params.require(:appointment).permit :user_id, :address, :company_id, :start_time, :end_time, :apply_id
  end

  def create_inforappointments
    @item = params[:states]
    inforappointments = []
    @item.each do |user_id|
      next if user_id.blank?
      info_appointment = Inforappointment.new(user_id: user_id, appointment_id: @appointment.id)
      info_appointment.create_activation_digest
      inforappointments << info_appointment
    end
    Inforappointment.import inforappointments
    load_template_member
    @appointment.inforappointments.each do |member|
      SendEmailJob.perform_later(member,@template)
    end
  end

  def load_template_member
    @template = Template.find_by id: params[:template]
  end

  def load_template_user
    @template_user = Template.find_by id: params[:template_user]
  end
end
