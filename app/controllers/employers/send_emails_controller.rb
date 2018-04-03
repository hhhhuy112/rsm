class Employers::SendEmailsController < ApplicationController
  before_action :load_company
  before_action :load_apply, :load_apply_status, :load_apply_statuses, except: :show
  before_action :load_oauth, only: :show

  def create
    SendEmailUserJob.perform_later params[:title], @apply, params[:template_content], @company, @apply_status
    update_content_email_apply_status
    send_mail_interviewer if @apply.interview_scheduled?
    @messages = t ".success"
    respond_to :js
  end

  def show
    @email_sent = EmailSent.find_by(id: params[:id])
    return if @email_sent.blank? || @oauth.blank?
    @oauth.check_access_token
    @email_sent.save_activity :show, current_user
    @email_sent.send_mail current_user
    @status_step = @email_sent.status_step
    @apply = @email_sent.apply
    send_mail_interviewer if @status_step.present? && @apply.present? && @status_step.is_status?(Settings.interview_scheduled)
    respond_to :js
  end

  private

  def update_content_email_apply_status
    ApplyStatus.transaction do
      apply_status = if @apply_status.status_step.is_status? Settings.pending
        apply_status_not_current = @apply.apply_statuses.not_current.first
        apply_status_not_current.present? ? apply_status_not_current : @apply_status
      else
        @apply_status
      end
      apply_status.update_attributes content_email: params[:template_content]
    end
  end

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
      SendEmailJob.perform_later inforappointment, @company, @apply
    end
  end

  def load_apply_statuses
    @apply_statuses = @apply.apply_statuses.includes(:status_step,
      appointment: [inforappointments: [:user]]).page params[:page]
  end
end
