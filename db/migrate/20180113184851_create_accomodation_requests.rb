class CreateAccomodationRequests < ActiveRecord::Migration[5.0]
  def change
    create_table :accomodation_requests do |t|

      t.timestamps
    end
  end
end
