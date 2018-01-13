class AddConectionsToARs < ActiveRecord::Migration[5.0]
  def change
    add_reference :accomodation_requests, :registry
    add_reference :accomodation_requests, :accomodation
    add_column :accomodation_requests, :accepted?, :boolean
    remove_reference :registry, :accomodations
  end
end
