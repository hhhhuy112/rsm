class CompanyMailer < ApplicationMailer
  add_template_helper(EmailHelper)
  default from: "framrecruit@gmail.com"

  def welcome_email apply
    @company = apply.company
    @apply = apply
    attachments[@apply.cv_identifier] = File.read("#{Rails.root}/public#{@apply.cv.url}")
    mail(to: @company.email, subject: t("company_mailer.welcome_email.subject"))
  end

  def user_mail apply
    @apply = apply
    mail(to: @apply.information[:email], subject: t("company_mailer.welcome_email.subject"))
  end

  def approved_user appointment, template
    @appointment = appointment
    @template = template
    @apply = @appointment.apply
    @company = @apply.company
    mail(to: @apply.information[:email], subject: t("company_mailer.welcome_email.subject"))
  end

  def send_member inforappointment, template
    @inforappointment = inforappointment
    @appointment = @inforappointment.appointment
    @template = template
    @user = @inforappointment.user
    mail(to: @user.email, subject: t("company_mailer.welcome_email.subject"))
  end
end
