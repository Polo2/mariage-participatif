class Message < ApplicationRecord
  belongs_to :resource, polymorphic: true
  belongs_to :user

  def update_as_read
    update! read: true
  end
end
