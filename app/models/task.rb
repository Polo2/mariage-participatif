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

  def unread_messages_count
    messages.where(read: false).count
  end

  def required_guests_quantity
    return unless services.any?
    services.map{ |s| s.capacity - s.guests.count }.sum
  end

  def unread_messages_count_to_display
    return "" unless unread_messages_count > 0
    "#{unread_messages_count} message#{unread_messages_count > 1 ? "s" : ""}"
  end

  def required_guests_quantity_to_display
    return "service complet :)" if required_guests_quantity.zero?
    "encore #{required_guests_quantity} personnes"
  end
end
