class DeviseMailer < Devise::Mailer
  layout "devise_mailer"

  add_template_helper EmailHelper
end
