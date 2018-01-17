class AddSloganToVegetables < ActiveRecord::Migration[5.0]
  def change
    add_column :vegetables, :slogan, :string
    add_column :vegetables, :capacity, :integer
  end
end
