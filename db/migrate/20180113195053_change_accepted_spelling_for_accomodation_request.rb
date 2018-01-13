class ChangeAcceptedSpellingForAccomodationRequest < ActiveRecord::Migration[5.0]
  def change
    remove_column :accomodation_requests, :accepted?
    add_column :accomodation_requests, :statut, :boolean
  end
end
