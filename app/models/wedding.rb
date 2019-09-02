class Wedding < ApplicationRecord
  belongs_to :user
  has_many :reviews, dependent: :destroy
  has_many :tasks, dependent: :destroy
  has_many :services, through: :tasks
  has_many :messages, through: :tasks
  has_many :registries, dependent: :destroy
  has_many :guests, through: :registries
  has_many :vegetables, through: :registries
  has_many :accomodations, dependent: :destroy

  scope :future, -> { where("date > ?", Date.current) }
  scope :passed, -> { where("date < ?", Date.current) }

  has_attachment :photo
  has_attachment :spouse_photo

  geocoded_by :location
  after_validation :geocode, if: :location_changed?

  def passed?
    date < Date.current
  end

  def services_count
    services.count
  end

  def complete_services_count
    services.select(&:is_service_complete?).count
  end

  def guests_registred_to_a_service_count
    guests.where.not(service_id: nil).count
  end

  def guests_needed_for_service_count
    services.pluck(:capacity).sum - guests_registred_to_a_service_count
  end

  def accomodations_count
    accomodations.count
  end

  def complete_accomodations_count
    accomodations.where(complete: true).count
  end

  def present_guests_count
    guests.where(presence: true).count
  end

  def absent_guests_count
    guests.where(presence: false).count
  end

  def answered_guests_count
    present_guests_count + absent_guests_count
  end

  def present_childs_count
    guests.where(presence: true).where(child: true).count
  end

  def tasks_with_service
    tasks.with_service
  end

  def tasks_without_service
    tasks.without_service
  end

  def unread_messages_count
    messages.where(read: false).count
  end

  def vegetables_count
    vegetables.count
  end
end
