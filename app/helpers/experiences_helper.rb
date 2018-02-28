module ExperiencesHelper
  def define_cancel_experience_id experience
    if experience.id?
      Settings.experiences.cancel_edit
    else
      Settings.experiences.cancel_new
    end
  end

  def check_experience user
    current_user.is_user?(user) ? t("experiences.describle") : t("experiences.blank")
  end
end
