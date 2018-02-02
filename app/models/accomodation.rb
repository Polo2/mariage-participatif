class Accomodation < ApplicationRecord
  belongs_to :wedding
  has_many :accomodation_requests, dependent: :destroy


  def is_complete?
    self.complete
  end

  def nb_of_guests
    sum = 0
    accomodation_requests.where(statut: true).each { |request| sum += request.registry.guests.where(presence: true).where(child: false).count }
    return sum
  end

  def guest_list
    guest_list = []
    accomodation_requests.where(statut: true).each  do |request|
      request.registry.guests.where(presence: true).where(child: false).each { |guest| guest_list << "#{request.registry.group_name.capitalize}, #{guest.name}" }
    end
    return guest_list
  end

end
