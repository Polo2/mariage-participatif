class RemoveReviewsAndAlbumsTables < ActiveRecord::Migration[5.2]
  def up
    drop_table :reviews
  end

  def down
    fail ActiveRecord::IrreversibleMigration
  end
end
