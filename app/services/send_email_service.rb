class SendEmailService
  def initialize email_sent, company, apply = nil
    @email_sent = email_sent
    @company = company
    @apply = apply
  end

  def send_email
    SendEmailUserJob.perform_later @email_sent, @company
  end

  private

  def load_apply
    @apply = Apply.find_by id: params[:apply_id]
    return if @apply.present?
    flash[:success] = t ".not_find_item"
    redirect_to root_path
  end

  def load_apply_status
    @apply_status = ApplyStatus.find_by id: params[:apply_status_id]
    return if @apply_status.present?
    flash[:success] = t ".not_find_item"
    redirect_to root_path
  end

  def send_mail_interviewer
    @apply.inforappointments.each do |inforappointment|
      SendEmailJob.perform_later inforappointment, @company
    end
  end

  def load_apply_statuses
    @apply_statuses = @apply.apply_statuses.includes(:status_step,
      appointment: [inforappointments: [:user]]).page params[:page]
  end
end
