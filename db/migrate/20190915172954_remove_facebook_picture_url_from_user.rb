class RemoveFacebookPictureUrlFromUser < ActiveRecord::Migration[5.2]
  def up
    remove_column :users, :facebook_picture_url
  end

  def down
    add_column :users, :facebook_picture_url, :string
  end
end
