class AddScoreIntegerToRegistry < ActiveRecord::Migration[5.0]
  def change
    remove_column :registries, :score
    add_column :registries, :core_as_integer, :integer
  end
end
