class Accomodation < ApplicationRecord
  belongs_to :wedding
  has_many :users

end
