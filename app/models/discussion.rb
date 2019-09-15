class Discussion < ApplicationRecord
  belongs_to :wedding
  has_many :messages, as: :resource, dependent: :destroy

  validates :name, presence: true

  def unread_messages_count
    messages.where(read: false).count
  end

  def unread_messages_count_to_display
    return "" unless unread_messages_count > 0
    "#{unread_messages_count} message#{unread_messages_count > 1 ? "s" : ""}"
  end
end
