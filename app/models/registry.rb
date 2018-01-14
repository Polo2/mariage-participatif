class Registry < ApplicationRecord
  belongs_to :wedding
  belongs_to :user
  has_many :guests, dependent: :destroy
  has_many :services, through: :guests
  has_many :accomodation_requests, dependent: :destroy

  accepts_nested_attributes_for :guests
  validates :email, presence: true

  before_create :set_user_id

  after_create :set_score_array

  # def status
  #   if @registry.guests.presence == true
  #     return "Confirmed"
  #   else
  #     return "Pending"
  #   end
  # end

  def update_score
    score
  end

  def score_as_array
    return [0,0,0,0]
  end

  private

  def set_user_id
    @user = User.find_by_email(email.downcase)

    if @user.present?
      self.user_id = @user.id
    end
  end

  def set_score_array
    score = 0
  end


end
