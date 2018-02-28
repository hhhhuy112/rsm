class CertificatesController < ApplicationController
  before_action :authenticate_user!
  before_action :current_ability
  load_and_authorize_resource param_method: :params_certificate
  before_action :load_certificates, only: :destroy

  def create
    respond_to do |format|
      if @certificate.save
        format.js{@message = t "certificate.create_success"}
      else
        format.js
      end
    end
  end

  def update
    respond_to do |format|
      if @certificate.update_attributes params_certificate
        format.js{@message = t "certificate.update_success"}
      else
        format.js
      end
    end
  end

  def destroy
    respond_to do |format|
      if @certificate.destroy
        format.js{@success = t "certificate.destroy_success"}
      else
        format.js{@fail = t "certificate.destroy_fail"}
      end
    end
  end

  private

  def load_certificates
    @certificates = current_user.certificates
  end

  def params_certificate
    params.require(:certificate).permit :name, :majors, :organization, :classification, :received_time
  end
end
