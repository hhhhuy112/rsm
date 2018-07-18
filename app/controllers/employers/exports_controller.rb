class Employers::ExportsController < Employers::EmployersController
  authorize_resource class: false
  before_action :load_info_evaluation, only: :index

  layout "evaluation_pdf/evaluation_pdf"

  def index
    respond_to do |format|
      format.pdf {send_evaluation_pdf}
      format.html
    end
  end

  private

  def load_info_evaluation
    @evaluation = Evaluation.includes(:apply, :knowledges, :skills, :currency).find_by id: params[:evaluation_id]
    return if @evaluation.present?
    flash[:danger] = t "not_found", error_message: Evaluation.name
    redirect_to employers_dashboards_path
  end

  def send_evaluation_pdf filename = nil
    send_file create_evaluation_pdf.to_pdf,
      filename: evaluation_pdf.filename,
      type: Settings.send_cv.type,
      disposition: Settings.send_cv.inline
  end

  def create_evaluation_pdf
    ExportService.new @evaluation.apply
  end
end
