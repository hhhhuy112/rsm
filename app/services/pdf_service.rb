class PdfService
  def initialize user
    @user = user
  end

  def to_pdf
    @kit = PDFKit.new(as_html, page_size: Settings.page_size.size)
  end

  def filename
    "CV#{user.id}.pdf"
  end
end
