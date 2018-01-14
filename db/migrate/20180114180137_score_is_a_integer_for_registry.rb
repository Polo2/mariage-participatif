class ScoreIsAIntegerForRegistry < ActiveRecord::Migration[5.0]
  def change
    remove_column :registries, :core_as_integer
    add_column :registries, :score_registry, :integer
  end
end
