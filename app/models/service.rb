class Service < ApplicationRecord
  belongs_to :task
  belongs_to :user
  has_many :guests

  validates :name, presence: true

  def is_service_complete?
    guests.count == capacity
  end

  def is_service_over_capacity?
    guests.count > capacity
  end
end
