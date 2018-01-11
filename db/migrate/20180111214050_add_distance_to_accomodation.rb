class AddDistanceToAccomodation < ActiveRecord::Migration[5.0]
  def change
    add_column :accomodations, :distance, :integer
    add_column :accomodations, :type, :string
  end
end
