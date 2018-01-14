class Accomodation < ApplicationRecord
  belongs_to :wedding
  has_many :accomodation_requests, dependent: :destroy


  def is_complete?
    self.complete
  end

end
