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

  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def flash_class level
    case level
    when :notice then "alert-info"
    when :error then "alert-danger"
    when :alert then "alert-warning"
    when :success then "alert-success"
    end
  end

  def check_index position
    position % Settings.dashboard.mod == Settings.dashboard.zero ? "dark-light" : ""
  end

  def total_apply total, value
    SelectApply.caclulate_applies total, value
  end

  def show_exampleview_user template, information, company
    (template.template_body.gsub("@image_company@", image_tag("framgia.png", size:Settings.apply.image)).
      gsub("@user@", information[:name].present? ? information[:name] : "").
      gsub("@company@", t("employers.templates.show.company", name: company.name)).
      gsub("@start_time@", information[:start_time].present? ? information[:start_time] : "").
      gsub("@address@", information[:address].present? ? information[:address] : "").
      gsub("@end_time@", information[:end_time].present? ? information[:end_time] : "").
      gsub("@offer_address@", information[:offer_address].present? ? information[:offer_address] : "").
      gsub("@requirement@", information[:requirement].present? ? information[:requirement] : "").
      gsub("@salary@", information[:salary].present? ? information[:salary] : "").
      gsub("@date_offer@", information[:date_offer].present? ? information[:date_offer] : "").
      gsub("@image_page@", image_tag("framgia.png", size:Settings.apply.image))).html_safe
  end
end
