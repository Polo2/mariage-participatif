module ApplicationHelper
  DAYS_NAME = %w[lundi mardi mercredi jeudi vendredi samedi dimanche]

  def avatar_for(user, options = {})
    if user.avatar.present?
      cl_image_tag user.avatar, options
    else
      image_tag "avatar_general.png", options
    end
  end

  def public_for(bool)
    bool ? "Oui" : "Non"
  end

  def background_image_for(vegetable,  options = {})
    if vegetable.photo.present?
      cl_image_path vegetable.photo, options
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

  def day_to_display(week_day)
    return unless (0..6).include? week_day
    DAYS_NAME[week_day]
  end
end
