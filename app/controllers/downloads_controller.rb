class DownloadsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_info_user, only: :show
  layout "cv_pdf/cv_pdf"

  def show
    respond_to do |format|
      format.pdf {send_user_pdf}
      format.html
    end
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

  def send_user_pdf
    send_file create_cv_pdf.to_pdf,
      filename: user_pdf.filename,
      type: Settings.send_cv.type,
      disposition: Settings.send_cv.inline
  end
end
