module CompaniesHelper
  def show_banner img_type
    image_tag @company.banner.url, class: img_type
  end

  def has_owner_job ids, id
    ids.include? id
  end

  def add_class_if_resource_has_error error
    if error.present?
      "has-error"
    end
  end
end
