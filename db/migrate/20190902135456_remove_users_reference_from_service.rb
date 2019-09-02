class RemoveUsersReferenceFromService < ActiveRecord::Migration[5.2]
  def change
    remove_reference :services, :user
  end

  def down
    add_reference :services, :user, foreign_key: true
  end
end
