class IsGuestAnAdult < ActiveRecord::Migration[5.0]
  def change
    add_column :guests, :adult, :boolean
  end
end
