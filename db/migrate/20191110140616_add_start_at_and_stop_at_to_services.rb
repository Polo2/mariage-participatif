class AddStartAtAndStopAtToServices < ActiveRecord::Migration[5.2]
  def change
    add_column :services, :start_at, :datetime
    add_column :services, :stop_at, :datetime
    add_column :services, :description, :string

    remove_column :services, :day
    remove_column :services, :appointment
    remove_column :services, :name
    remove_column :services, :details
  end
end
