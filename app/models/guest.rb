class Guest < ApplicationRecord
  belongs_to :registry
  belongs_to :service


  validates :name, presence: true
end
