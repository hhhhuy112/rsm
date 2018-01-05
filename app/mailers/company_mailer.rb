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

<<<<<<< HEAD
<<<<<<< HEAD
=======
>>>>>>> fa774d8... fix status applies 1
  def review_not_selected  apply, company
    @apply = apply
    @company = company
    mail(to: @apply.information[:email], subject: t("company_mailer.welcome_email.subject"))
  end

  def interview_scheduled_candidate appointment, apply, template, company
<<<<<<< HEAD
    @appointment = appointment
    @template = template
    @apply = apply
    @company = company
=======
  def approved_user appointment, apply, template
    @appointment = appointment
    @template = template
    @apply = apply
>>>>>>> bbf4e01... fix status apply
=======
    @appointment = appointment
    @template = template
    @apply = apply
    @company = company
>>>>>>> fa774d8... fix status applies 1
    mail(to: @apply.information[:email], subject: t("company_mailer.welcome_email.subject"))
  end

  def interview_scheduled_interviewer inforappointment, template, company
    @inforappointment = inforappointment
    @appointment = @inforappointment.appointment
    @template = template
    @user = @inforappointment.user
    @company = company
    mail(to: @user.email, subject: t("company_mailer.welcome_email.subject"))
  end
end
