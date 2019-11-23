class Wedding < ApplicationRecord
  belongs_to :user

  validates :first_name_1, presence: true
  validates :first_name_2, presence: true
  validates :description, presence: true
  validates :location, presence: true
  validates :date, presence: true
  validates :deadline, presence: true

  validate :date_cannot_be_in_the_past
  validate :deadline_date_has_to_be_until_now_and_wedding_date

  has_many :tasks, dependent: :destroy
  has_many :services, through: :tasks
  has_many :discussions, dependent: :destroy
  has_many :registries, dependent: :destroy
  has_many :guests, through: :registries
  has_many :vegetables, through: :registries
  has_many :accomodations, dependent: :destroy

  scope :future, -> { where("date > ?", Date.current) }
  scope :passed, -> { where("date < ?", Date.current) }

  mount_uploader :photo, PhotoUploader
  mount_uploader :spouse_photo, PhotoUploader

  geocoded_by :location
  after_validation :geocode, if: :location_changed?

  def passed?
    date < Date.current
  end

  def title
    couple_first_names + ", Mariage Participatif"
  end

  def services_count
    services.count
  end

  def couple_first_names
    [first_name_1, first_name_2].join(" & ")
  end

  def complete_services_count
    services.select(&:is_service_complete?).count
  end

  def guests_registred_to_a_service_count
    guests.where.not(service_id: nil).count
  end

  def guests_needed_for_service_count
    services.pluck(:capacity).sum - guests_registred_to_a_service_count
  end

  def accomodations_count
    accomodations.count
  end

  def complete_accomodations_count
    accomodations.where(complete: true).count
  end

  def present_guests_count
    guests.where(presence: true).count
  end

  def absent_guests_count
    guests.where(presence: false).count
  end

  def answered_guests_count
    present_guests_count + absent_guests_count
  end

  def present_childs_count
    guests.where(presence: true).where(child: true).count
  end

  def tasks_with_service
    tasks.with_service
  end

  def tasks_without_service
    tasks.without_service
  end

  def unread_messages_count
    messages.where(read: false).count
  end

  def messages
    task_messages.or(discussion_messages)
  end

  def vegetables_count
    vegetables.count
  end

  def present_guests_text
    present_guests_count > 1 ? "Réponses OUI" : "Réponse OUI"
  end

  def unread_messages_text
    unread_messages_count > 1 ? "nouveaux messages" : "nouveau message"
  end

  def services_text
    services_count > 1 ? "services proposés" : "service proposé"
  end

private

  def task_messages
    Message.where(resource_type: "Task")
      .where resource_id: self.tasks.pluck(:id)
  end

  def discussion_messages
    Message.where(resource_type: "Discussion")
      .where resource_id: self.discussions.pluck(:id)
  end

  def date_cannot_be_in_the_past
    return unless date
    if date < Time.now
      errors.add(:date, "le mariage est déjà passé ?")
    end
  end

  def deadline_date_has_to_be_until_now_and_wedding_date
    return unless deadline && date
    if deadline < Time.now || deadline > date
      errors.add(:deadline, "entre maintenant et avant le mariage")
    end
  end
end
