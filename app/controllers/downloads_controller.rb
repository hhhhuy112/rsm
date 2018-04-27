class DownloadsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_info_user, only: :show
  before_action :load_service, only: [:attachment, :show_attachment]

  layout "cv_pdf/cv_pdf"

  def show
    respond_to do |format|
      format.pdf {send_user_pdf}
      format.html
    end
  end

  def attachment
    @url = request.url.sub(/attachment/, Settings.service_googles.show_attachment)
    respond_to do |format|
      format.html
      format.js
    end
  end

  def show_attachment
    @email_google = @google_client_service.load_email(params[:id]).first
    filename = file_path @email_google
    send_user_pdf_attachment(filename)
  end

  private

  def load_info_user
    @user = current_user
    @achievements = @user.achievements
    @certificates = @user.certificates
    @clubs = @user.clubs
    @experiences = @user.experiences
  end

  def create_cv_pdf
    PdfService.new @user
  end

  def send_user_pdf filename = nil
    send_file create_cv_pdf.to_pdf,
      filename: user_pdf.filename,
      type: Settings.send_cv.type,
      disposition: Settings.send_cv.inline
  end

  def send_user_pdf_attachment filename
    send_file filename,
      type: Settings.send_cv.type,
      disposition: Settings.send_cv.inline
  end
end
