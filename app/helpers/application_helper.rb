module ApplicationHelper

  def avatar_for(user, options = {})

    if user.avatar.present?
      cl_image_tag user.avatar.path, options
    else
      image_tag 'avatar_general.png', options
    end
  end

  def public_for(bool)
    bool ? "Yes" : "No"
  end

  def background_image_for(vegetable,  options = {})

    if vegetable.photo.present?
      cl_image_path vegetable.photo.path, options
    else
      image_path 'salade.jpg', options
    end
  end

  def presence_for(presence)
    if presence.nil?
      "#{icon('question-circle-o')} En attente ..".html_safe
    elsif presence
      "#{icon('check-square')} Oui".html_safe
    else
      "#{icon('times-circle')} Non".html_safe
    end
  end
end
