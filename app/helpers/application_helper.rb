module ApplicationHelper
  def full_title page_title = ""
    base_title = I18n.t("app")
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end

  def header_title title = ""
    title
  end


  def define_style_placeholder list
    Settings.placeholder.display_none if list.present?
  end

  def show_errors object, name_attribute, name_error
   messages =  object.errors.messages[name_attribute]
   return "#{messages[0]}" if messages.present?
  end

  def get_value_user object, user
    object.id.present? ? object.user_id : user.id
  end
end

