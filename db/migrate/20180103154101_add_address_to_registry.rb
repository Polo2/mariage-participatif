class AddAddressToRegistry < ActiveRecord::Migration[5.0]
  def change
    add_column :registries, :address , :string
    add_column :registries, :zipcode, :integer
    add_column :registries, :city, :string
    add_column :registries, :score, :integer
  end
end
