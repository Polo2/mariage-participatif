class Accomodation < ApplicationRecord
  belongs_to :wedding
  has_many :accomodation_requests, dependent: :destroy

end
