class Employers::ConfirmAppointmentsController < ApplicationController

  def edit
    inforappointment = Inforappointment.find_by(id: params[:id])
    if inforappointment && inforappointment.activation_digest == params[:activation_digest]
      update_appointment inforappointment
    else
      flash[:warning] = t "accountactivations.fail"
    end
    redirect_to root_url
  end

  private


  def update_appointment inforappointment
    if inforappointment.update_attributes(activated:
      params[:not_agree].present? ? Settings.inforappointment.not_agree : Settings.inforappointment.agree)
      flash[:success] = t "accountactivations.success"
    else
      flash[:info] = t "accountactivations.info_not"
    end
    sign_in inforappointment.user
  end
end
