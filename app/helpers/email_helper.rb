module EmailHelper
  def email_image_tag image, **options
    attachments[image] = File.read(Rails.root.join("app/assets/images/#{image}"))
    image_tag attachments[image].url, **options
  end

  def image_carrierwave_tag image, **options
    attachments[image.logo_identifier] =  File.read("#{Rails.root}/public#{image.logo.url}")
    image_tag attachments[image.logo_identifier].url, **options
  end

  def send_template_member template, appointment, user, inforappointment, company
    template.template_body.
    gsub("@image_company@", image_carrierwave_tag(company, class: "img-lastss")).
    gsub("@user_name@", user.name).
    gsub("@agree@", link_to(t("company_mailer.welcome_email.agree"),
      edit_employers_confirm_appointment_url(inforappointment.id,
      activation_digest: inforappointment.activation_digest, subdomain: company.subdomain), class: "button")).
    gsub("@not_agree@", link_to(t("company_mailer.welcome_email.not_agree"),
      edit_employers_confirm_appointment_url(inforappointment.id,
      activation_digest: inforappointment.activation_digest, not_agree: t("not_agree"), subdomain: company.subdomain),
      class: "buttona")).
    gsub("@image_framgia@", email_image_tag("framgia.png", class: "img-lastss")).html_safe
  end

  def send_template_user template, apply, company, appointment
    template.template_body.gsub("@image_company@",
      image_carrierwave_tag(company, class: "img-lastss")).
      gsub("@user_name@", apply.information[:name]).
      gsub("@user_job@", apply.job.name).
      gsub("@user_company@", company.name).
      gsub("@user_address@", appointment.address).
      gsub("@user_time@",(l appointment.start_time, format: :long)).
      gsub("@image_page@", email_image_tag("framgia.png", class: "img-lastss")).html_safe
  end
end
