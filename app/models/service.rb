class Service < ApplicationRecord
  belongs_to :task
  has_many :guests

  validates :description, presence: true
  validates :capacity,
    numericality: { only_integer: true, greater_than: 0 }

  def remaining_places_count
    capacity - guests.count
  end

  def is_service_complete?
    remaining_places_count.zero?
  end

  def schedule
    [start_at.strftime("%H h %M"), stop_at.strftime("%H h %M")].join(" - ")
  end

  def week_day
    start_at.strftime("%u").to_i - 1
  end
end
