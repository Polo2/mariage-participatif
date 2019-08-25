class AccomodationRequest < ApplicationRecord
  belongs_to :registry
  belongs_to :accomodation

  after_create :send_request_email

  def present_adults_guests
    registry.guests.where(presence: true, child: false)
  end

  private

  def send_request_email
    RequestMailer.new_request(self).deliver_now if !statut
  end
end
