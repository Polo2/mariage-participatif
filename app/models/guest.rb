class Guest < ApplicationRecord
  belongs_to :registry
  belongs_to :service, optional: true

  validates :name, presence: true
end
