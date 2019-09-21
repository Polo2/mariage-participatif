class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :weddings
  has_many :registries
  has_many :messages, dependent: :destroy

  after_create :link_registries
  has_attachment :avatar, accept: [:jpg, :png, :gif, :jpeg]

  def link_registries
    Registry.where(email: email.downcase.strip).find_each do |registry|
      registry.user = self
      registry.guests.each { |g| g.presence = nil }
      registry.save
    end
  end

protected

  def send_welcome_email
    UserMailer.welcome(self).deliver_now
  end
end
