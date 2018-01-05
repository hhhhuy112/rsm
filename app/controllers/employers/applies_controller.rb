class Employers::AppliesController < Employers::EmployersController
  before_action :load_members, only: [:edit, :update]

  def edit
    @apply.build_appointment company_id: @company.id
    @template_members = current_user.templates.template_member
    @template_users = current_user.templates.template_user
    respond_to do |format|
      format.js
    end
  end

  def update
    respond_to do |format|
      if @apply.update_attributes apply_params
        @appointment = @apply.appointment
        if @apply.interview_scheduled?
          SendEmailUserJob.perform_later @appointment, @apply
          create_inforappointments if params[:states].present?
        else
          Appointment.transaction do
            @appointment.destroy if @appointment.present?
          end
        end
        format.js{@messages = t "employers.applies.update.success"}
      else
        format.js{@errors = t "employers.applies.update.fail"}
      end
    end
  end

  private

  def apply_params
    params.require(:apply).permit :status, appointment_attributes: %i(user_id address company_id start_time end_time apply_id)
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
    @appointment.inforappointments.each do |member|
      SendEmailJob.perform_later(member)
    end
  end
end
