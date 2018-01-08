class AddDetailsToService < ActiveRecord::Migration[5.0]
  def change
    add_column :services, :day, :string
    add_column :services, :location, :string
    add_column :services, :details, :string
  end
end
