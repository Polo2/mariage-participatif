class Message < ApplicationRecord
  belongs_to :resource, polymorphic: true
  belongs_to :user

  def update_as_read
    update! read: true
  end

  def posted_by_wedding_owner?
    user == resource.wedding.user
  end

  def css_class
    posted_by_wedding_owner? ? "wedder" : "invited"
  end

  def author
    if posted_by_wedding_owner?
      resource.wedding.couple_first_names
    else
      user.first_name
    end
  end
end
