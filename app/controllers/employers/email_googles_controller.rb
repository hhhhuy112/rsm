class Employers::EmailGooglesController < Employers::EmployersController
  before_action :load_oauth, :check_send_mail
  before_action :load_service
  before_action :load_page, :get_data, only: :index

  def index
    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
    @email_google = @google_client_service.load_email(params[:id]).first
    save_file
  end

  private

  def save_file
    begin
      filename = file_path @email_google
      dirname = File.dirname(filename)
      unless File.directory?(dirname)
        FileUtils.mkdir_p(dirname)
      end
      file_cv = File.open(filename, Settings.service_googles.write_file)
      file_cv.write(@email_google.attachments.first.read)
    rescue IOError => e
      redirect_to :back
      flash[:danger] = t ".not_save_file"
    ensure
      @path = request.url
      file_cv.close if file_cv.present?
    end
  end

  def get_data
    page = load_page
    start_index, end_index = load_pagination page
    list_email_googles = @google_client_service.get_emails.reverse
    email_googles = list_email_googles[start_index..end_index]
    size = list_email_googles.size
    @data = Supports::EmailGoogleSupport.new( page, start_index, end_index, email_googles, size).get_data
  end

  def load_service
    @google_client_service = GoogleClientService.new current_user
  end

  def load_oauth
    @oauth = current_user.oauth
  end

  def load_token
    @token = @oauth.token
  end

  def check_send_mail
    @oauth.check_access_token
  end

  def load_page
    @page = (params[:page] || Settings.service_googles.start_page).to_i
  end

  def load_pagination page
    page_start = page - Settings.service_googles.start_page
    offset_start = page_start * Settings.service_googles.per_page
    offset_end = offset_start + Settings.service_googles.per_page
    offset_start = offset_start > 0 ? offset_start : Settings.service_googles.start_page
    [offset_start, offset_end]
  end
end
