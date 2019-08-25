module ApplicationHelper
  def avatar_for(user, options = {})
    if user.avatar.present?
      cl_image_tag user.avatar.path, options
    else
      image_tag "avatar_general.png", options
    end
  end

  def public_for(bool)
    bool ? "Oui" : "Non"
  end

  def background_image_for(vegetable,  options = {})
    if vegetable.photo.present?
      cl_image_path vegetable.photo.path, options
    else
      image_path "bocaux.jpg", options
    end
  end

  def presence_for(presence)
    if presence.nil?
      "#{icon("far", "question-circle")} En attente ..".html_safe
    elsif presence
      "#{icon("far", "check-square")} Oui".html_safe
    else
      "#{icon("far", "times-circle")} Non".html_safe
    end
  end
end
