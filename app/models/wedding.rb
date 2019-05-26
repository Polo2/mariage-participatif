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
  has_many :accomodation_requests, through: :accomodations

  scope :future, -> { where('date > ?', Date.current) }
  scope :passed, -> { where('date < ?', Date.current) }

  has_attachment :photo
  has_attachment :spouse_photo
  has_attachments :album_photos, maximun: 30

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

  def nb_of_guests_registred_to_a_service_count
    guests.where.not(service_id: nil).count
  end

  def guests_needed_for_service_count
    services.pluck(:capacity).sum - nb_of_guests_registred_to_a_service_count
  end

  # TODO : should be improved
  def nb_of_guests_with_accomodation_count
    registries.reject { |r| r.accomodation_request_ids.empty? }.map do |registry|
      if registry.accomodation_requests.last.statut
        registry.guests.where(child: false).where(presence: true).count
      end
    end.sum
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
end
