class CreateAccomodations < ActiveRecord::Migration[5.0]
  def change
    create_table :accomodations do |t|
      t.string :name
      t.integer :capacity
      t.integer :price
      t.string :location
      t.string :contact_name
      t.string :contact_information

      t.timestamps
    end
  end
end
