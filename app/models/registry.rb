class Registry < ApplicationRecord
  belongs_to :wedding
  belongs_to :user
  has_many :guests, dependent: :destroy
  has_many :services, through: :guests
  has_many :accomodation_requests, dependent: :destroy
  has_many :vegetables, dependent: :destroy

  accepts_nested_attributes_for :guests
  validates :email, presence: true

  before_create :set_user_id

  def update_score!
    score = 0
    score += self.guests.where(presence: nil).empty? ? 25 : 0
    score += ( (self.services.count == self.guests.where(child: false).where(presence: true).count) && self.guests.where(presence: nil).empty?  ) ? 25 : 0
    if ( !self.accomodation_request_ids.empty? && self.guests.where(presence: nil).empty? )
      score += self.accomodation_requests.last.statut ? 25 : 15
    end
    score += ( !self.vegetables.empty? && self.guests.where(presence: nil).empty? ) ? 25 : 0
    self.update!(score_registry: score)
  end

  private

  def set_user_id
    @user = User.find_by_email(email.downcase)

    if @user.present?
      self.user_id = @user.id
    end
  end
end
