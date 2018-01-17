class Vegetable < ApplicationRecord
belongs_to :registry

validates :slogan, presence: true, length: { maximum: 33, too_short: "33 charactères maximum" }
validates :capacity, numericality: { only_integer: true, greater_than: 0 }

  has_attachment :photo, accept: [:jpg, :png, :gif, :jpeg]
end
