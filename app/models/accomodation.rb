class Accomodation < ApplicationRecord
  belongs_to :wedding
  has_many :accomodation_requests, dependent: :destroy

  def guests_quantity
    accomodation_requests
      .where(statut: true)
      .map do |request|
        request.present_adults_guests.count
      end
      .sum
  end

  def guest_list
    accomodation_requests
      .where(statut: true)
      .map do |request|
        request.present_adults_guests.map do |guest|
          "#{request.registry.group_name.capitalize}, #{guest.name}"
        end
      end
      .compact
  end
end
