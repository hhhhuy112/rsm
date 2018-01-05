module ApplicationHelper
  def full_title page_title = ""
    base_title = I18n.t("app")
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end

  def branches_footer branches
    render branches
  end

  def header_title title = ""
    title
  end

  def define_style_placeholder list
    Settings.placeholder.display_none if list.present?
  end

  def show_errors object, name_attribute, name_error
    messages = object.errors.messages[name_attribute]
    return "#{messages[0]}" if messages.present?
  end

  def get_value_user object, user
    object.id.present? ? object.user_id : user.id
  end

  def show_exampleview_user template
    return "" if template.blank?
    template.template_body.gsub("@image_company@", image_tag("framgia.png", size:Settings.apply.image)).
      gsub("@user_name@", current_user.name).
      gsub("@not_agree@", button_tag("agree", class: "buttona")).
      gsub("@agree@", button_tag("agree", class: "button")).
      gsub("@user_job@", t("company_mailer.welcome_email.job")).
      gsub("@user_company@",t("company_mailer.welcome_email.company")).
      gsub("@user_address@", t("company_mailer.welcome_email.address")).
      gsub("@user_time@", t("company_mailer.welcome_email.time")).
      gsub("@image_framgia@", image_tag("framgia.png", size: Settings.apply.image)).
      gsub("@image_page@", image_tag("framgia.png", size:Settings.apply.image))
  end
end
