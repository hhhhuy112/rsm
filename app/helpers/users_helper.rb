module UsersHelper
  def show_avatar user
    image_tag user.picture.url, class: "img-thumbnail img-profile"
  end

  def show_avatar_sidebar user
    image_tag user.picture.url, class: "avatar_user"
  end
end
