class AddAtributesToVegetables < ActiveRecord::Migration[5.0]
  def change
    add_column :vegetables, :name, :string
    add_column :vegetables, :photo, :string
    add_reference :vegetables, :registry

  end
end
