class Task < ApplicationRecord
  belongs_to :wedding
  # has_many :elements, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_many :services, dependent: :destroy

  # TODO: should be improved
  def self.with_service
    joins(:services).where.not(services: []).distinct
  end

  def self.without_service
    where.not id: self.with_service.pluck(:id)
  end
end
