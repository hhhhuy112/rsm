module CertificatesHelper
  def define_cancel_certificate_id certificate
    if certificate.id?
      Settings.certificate_cancel.edit
    else
      Settings.certificate_cancel.new
    end
  end
end
