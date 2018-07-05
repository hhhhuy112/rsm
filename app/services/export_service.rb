class ExportService
  def initialize apply
    @apply = apply
  end

  def to_pdf
    @kit = PDFKit.new(as_html, page_size: Settings.page_size.size)
  end

  def filename
    "evaluation#{apply.information[:name]}.pdf"
  end
end
