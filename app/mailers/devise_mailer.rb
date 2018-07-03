class DeviseMailer < Devise::Mailer
  layout "devise_mailer"

  add_template_helper EmailHelper

  def confirmation_instructions(record, token, opts={})
    super
  end

end
