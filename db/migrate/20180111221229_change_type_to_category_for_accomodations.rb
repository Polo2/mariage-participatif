class ChangeTypeToCategoryForAccomodations < ActiveRecord::Migration[5.0]
  def change
    remove_column :accomodations, :type
    add_column :accomodations, :category , :string
  end
end
