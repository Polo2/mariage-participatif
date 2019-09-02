class RemoveAccomodationRequest < ActiveRecord::Migration[5.2]
  def up
    drop_table :accomodation_requests
  end

  def down
    create_table :accomodation_requests do |t|
      t.boolean :statut
      t.references :registry
      t.references :accomodation

      t.timestamps
    end
  end
end
