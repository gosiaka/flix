module UsersHelper

  def profile_image(user, size=80)
    url = "https://secure.gravatar.com/avatar/#{user.gravatar_id}?s=#{size}"
    image_tag(url, alt: user.name)
  end

  def name_or_username(user)
    user.username || user.name
  end
end