class Employers::AppliesController < Employers::EmployersController
<<<<<<< HEAD
<<<<<<< HEAD
  before_action :load_members, :load_templates, only: [:edit, :update]
  before_action :load_template_selected, only: :update

  def edit
    @apply.build_appointment company_id: @company.id
=======
  before_action :load_members, only: [:edit, :update]

  def edit
    @apply.build_appointment company_id: @company.id
    @template_members = current_user.templates.template_member
    @template_users = current_user.templates.template_user
>>>>>>> bbf4e01... fix status apply
=======
  before_action :load_members, :load_templates, only: [:edit, :update]
  before_action :load_template_selected, only: :update

  def edit
    @apply.build_appointment company_id: @company.id
>>>>>>> fa774d8... fix status applies 1
    respond_to do |format|
      format.js
    end
  end
<<<<<<< HEAD

  def show ;end
=======
>>>>>>> bbf4e01... fix status apply

  def show ;end

  def update
    respond_to do |format|
      if @apply.update_attributes apply_params
<<<<<<< HEAD
<<<<<<< HEAD
        handling_after_update_success
=======
        @appointment = @apply.appointment
        if @apply.interview_scheduled?
          SendEmailUserJob.perform_later @appointment, @apply
          create_inforappointments if params[:states].present?
        else
          Appointment.transaction do
            @appointment.destroy if @appointment.present?
          end
        end
>>>>>>> bbf4e01... fix status apply
=======
        handling_after_update_success
>>>>>>> fa774d8... fix status applies 1
        format.js{@messages = t "employers.applies.update.success"}
      else
        format.js{@errors = t "employers.applies.update.fail"}
      end
    end
  end

  private

  def handling_after_update_success
    @appointment = @apply.appointment
    case
    when @apply.review_not_selected?

    when @apply.interview_scheduled?
      handling_with_interview_scheduled
    else
      reset_appointment
    end
  end

  def handling_with_review_not_selected
    SendEmailUserJob.perform_later @appointment, @apply, @template, @company
    create_inforappointments if params[:states].present?
  end

  def handling_with_interview_scheduled
    SendEmailUserJob.perform_later @appointment, @apply, @template, @company
    create_inforappointments if params[:states].present?
  end

  def reset_appointment
    Appointment.transaction do
      @appointment.destroy if @appointment.present?
    end
  end

  def apply_params
    params.require(:apply).permit :status, appointment_attributes: %i(user_id address company_id start_time end_time apply_id)
  end

  def create_inforappointments
<<<<<<< HEAD
<<<<<<< HEAD
=======
>>>>>>> fa774d8... fix status applies 1
    @members = params[:states]
    inforappointments = @members.map do |member_id|
      next if member_id.blank?
      info_appointment = Inforappointment.new(user_id: member_id, appointment_id: @appointment.id)
<<<<<<< HEAD
      info_appointment.create_activation_digest
      info_appointment
    end
    send_mail_interviewer if Inforappointment.import inforappointments
  end

  def send_mail_interviewer
    @appointment.inforappointments.each do |inforappointment|
      SendEmailJob.perform_later inforappointment, @template_user, @company
  end
end

  def load_template_selected
    @template = Template.find_by id: params[:template]
    @template_user = Template.find_by id: params[:template_user]
=======
    @item = params[:states]
    inforappointments = []
    @item.each do |user_id|
      next if user_id.blank?
      info_appointment = Inforappointment.new(user_id: user_id, appointment_id: @appointment.id)
=======
>>>>>>> fa774d8... fix status applies 1
      info_appointment.create_activation_digest
      info_appointment
    end
<<<<<<< HEAD
>>>>>>> bbf4e01... fix status apply
=======
    send_mail_interviewer if Inforappointment.import inforappointments
  end

  def send_mail_interviewer
    @appointment.inforappointments.each do |inforappointment|
      SendEmailJob.perform_later inforappointment, @template_user, @company
  end
end

  def load_template_selected
    @template = Template.find_by id: params[:template]
    @template_user = Template.find_by id: params[:template_user]
>>>>>>> fa774d8... fix status applies 1
  end
end
