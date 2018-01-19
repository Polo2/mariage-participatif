class Message < ApplicationRecord
  belongs_to :task
  belongs_to :user


  def update_as_read
    self.read = true
    self.save
  end
end
