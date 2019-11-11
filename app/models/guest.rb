class Guest < ApplicationRecord
  belongs_to :registry
  belongs_to :service, optional: true

  validates :name, presence: true

  def self.where_service_is_required
    # TODO : adapt sql, one where clause should be enough
    where(child: false).where(presence: true).where(service_id: nil)
  end
end
