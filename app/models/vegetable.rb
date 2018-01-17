class Vegetable < ApplicationRecord
belongs_to :registry

  has_attachment :photo, accept: [:jpg, :png, :gif, :jpeg]
end
