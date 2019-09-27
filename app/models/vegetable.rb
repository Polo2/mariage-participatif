class Vegetable < ApplicationRecord
  belongs_to :registry

  mount_uploader :photo, PhotoUploader
end
