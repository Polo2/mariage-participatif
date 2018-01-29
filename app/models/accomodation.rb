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

end
