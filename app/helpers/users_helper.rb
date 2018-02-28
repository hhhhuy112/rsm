module UsersHelper
  def show_avatar user
    image_tag user.picture.url, class: "img-thumbnail img-profile"
  end
end
