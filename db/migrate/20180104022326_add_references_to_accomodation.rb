class AddReferencesToAccomodation < ActiveRecord::Migration[5.0]
  def change
    add_reference :accomodations, :wedding
    add_reference :registries, :accomodation
  end
end
