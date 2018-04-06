class CompanyMailer < ApplicationMailer
  add_template_helper(EmailHelper)
  default from: "framrecruit@gmail.com"

  def welcome_email apply
    @company = apply.company
    @apply = apply
    attachments[@apply.cv_identifier] = File.read("#{Rails.root}/public#{@apply.cv.url}")
    mail(to: @company.email, subject: t("company_mailer.welcome_email.notification"))
  end

  def user_mail apply
    @apply = apply
    mail(to: @apply.information[:email], subject: t("company_mailer.welcome_email.notification"))
  end

   def send_mailer_candidate content, company, title, email
    @content = content
    @company = company
    mail(to: email, subject: title)
  end

  def send_mailer_interviewer appointment, apply, company
    @appointment = appointment
    @user_emails = @appointment.inforappointments.map {|info| info.user_email}
    @company = company
    @apply = apply
    mail(to: @user_emails, subject: t("company_mailer.welcome_email.subject"))
  end
end
