class Service < ApplicationRecord
  belongs_to :task
  has_many :guests

  validates :name, presence: true
  validates :capacity,
    numericality: { only_integer: true, greater_than_or_equal_to: 1 }

  def is_service_complete?
    guests.count == capacity
  end

  def is_service_over_capacity?
    guests.count > capacity
  end
end
