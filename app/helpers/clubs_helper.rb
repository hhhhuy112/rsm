module ClubsHelper
  def show_endtime club
    if club.current?
      t "clubs.helpers.present"
    else
      l club.end_time, format: :long
    end
  end

  def define_cancel_club_id club
    if club.id?
      "cancel_club_edit"
    else
      "cancel_club_new"
    end
  end

  def check_club user
    current_user.is_user?(user) ? t("clubs.describle") : t("clubs.blank")
  end
end
