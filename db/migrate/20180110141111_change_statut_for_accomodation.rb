class ChangeStatutForAccomodation < ActiveRecord::Migration[5.0]
  def change
    remove_column :accomodations, :price
    remove_column :accomodations, :contact_information
    add_column :accomodations, :contact_email, :string
    add_column :accomodations, :contact_website, :string
    add_column :accomodations, :contact_phone, :string
    add_column :accomodations, :complete?, :boolean
  end
end
