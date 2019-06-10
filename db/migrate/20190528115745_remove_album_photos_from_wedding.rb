class RemoveAlbumPhotosFromWedding < ActiveRecord::Migration[5.0]
  def change
    remove_column :weddings, :album_photos
  end
end
