class Service < ApplicationRecord
  belongs_to :task
  belongs_to :user
  has_many :guests

  validates :name, presence: true
end
