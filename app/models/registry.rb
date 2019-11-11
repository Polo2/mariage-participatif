class Registry < ApplicationRecord
  belongs_to :wedding
  belongs_to :user
  has_many :guests, dependent: :destroy
  has_many :services, through: :guests
  has_many :vegetables, dependent: :destroy

  accepts_nested_attributes_for :guests
  validates :email, presence: true

  before_create :set_user

  def update_score!
    score = 1
    score += guests.where(presence: nil).empty? ? 33 : 0
    score += (services.count == guests.where_service_is_required) ? 33 : 0
    score += (!vegetables.empty? && guests.where(presence: nil).empty?) ? 33 : 0
    update! score_registry: score
  end

  private

  def set_user
    self.user = User.find_by_email(email.downcase)
  end
end
