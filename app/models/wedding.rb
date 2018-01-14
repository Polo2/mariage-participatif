class Wedding < ApplicationRecord
  belongs_to :user
  has_many :reviews, dependent: :destroy
  has_many :tasks, dependent: :destroy
  has_many :registries, dependent: :destroy
  has_many :accomodations, dependent: :destroy
  has_many :guests, through: :registries
  has_many :accomodation_requests, through: :accomodations

  scope :future, -> { where('date > ?', Date.current) }
  scope :passed, -> { where('date < ?', Date.current) }

  # has_many :messages, through: :tasks
  # has_many :reviews, dependent: :destroy
  has_attachment :photo
  has_attachment :spouse_photo
  has_attachments :album_photos, maximun: 30

  geocoded_by :location
  after_validation :geocode, if: :location_changed?

  def passed?
    date < Date.current
  end

  def services_count
    compteur = 0
    tasks_list = self.tasks
    tasks_list.each { |t| compteur += t.services.count }
    compteur
  end

  def complete_services_count
    compteur = 0
    tasks_list = self.tasks
    tasks_list.each do |t|
      complete_services = t.services.select{ |s| s.is_service_complete? }
      compteur += complete_services.count
    end
    compteur
  end

  def nb_of_guests_registred_to_a_service_count
    guest_registred_list = []
    reg_list = self.registries
    reg_list.each do |reg|
      reg.guests.each do |guest|
        guest_registred_list << guest if guest.service_id?
      end
    end
    return guest_registred_list.length
  end

  def guests_needed_for_service_count
    compteur = 0
    job_service_list = []
    tasks_list = self.tasks
    tasks_list.each do |t|
      ser_vices = t.services
      ser_vices.each { |s| compteur += s.capacity.to_i  }
    end
    job_service_list.each { |s| compteur += s.capacity }

    return (compteur - nb_of_guests_registred_to_a_service_count)
  end

  def nb_of_guests_with_accomodation_count
    compteur = 0
    accomodations_list = self.accomodations
    reg_list = self.registries
    # reg_list_with_accomodation_request = self.registries.select { |reg| reg.accomodation_request_ids.empty? }
    reg_list.each do |reg|
      present_adults_guests = reg.guests.where(child: false).where(presence: true)
      unless reg.accomodation_request_ids.empty?
        compteur += present_adults_guests.count if reg.accomodation_requests.last.statut
      end
    end
    return compteur
  end

  def tasks_with_service
    tasks_list = self.tasks
    tasks_with_service = tasks_list.select { |task|  task.services.count > 0 }
    return tasks_with_service
  end

  def tasks_without_service
    tasks_list = self.tasks
    tasks_without_service = tasks_list.select { |task|  task.services.count == 0 }
    return tasks_without_service
  end

end
