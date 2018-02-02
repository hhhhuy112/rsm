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

  def content_email_candidate email_sent, company
    @title = email_sent.title
    @template = email_sent.content
    @company = company
    mail(to: "minhhuyho2011@gmail.com", subject: @title)
  end

  def interview_scheduled_interviewer inforappointment, company, apply
    @inforappointment = inforappointment
    @user = @inforappointment.user
    @company = company
    @apply = apply
    mail(to: @user.email, subject: t("company_mailer.welcome_email.subject"))
  end
end
