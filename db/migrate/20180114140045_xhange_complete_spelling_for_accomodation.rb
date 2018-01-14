class XhangeCompleteSpellingForAccomodation < ActiveRecord::Migration[5.0]
  def change
    remove_column :accomodations, :complete?
    add_column :accomodations, :complete, :boolean
  end
end
