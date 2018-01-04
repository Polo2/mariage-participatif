class AddReferenceToGuest < ActiveRecord::Migration[5.0]
  def change
    add_reference :guests, :service
  end
end
