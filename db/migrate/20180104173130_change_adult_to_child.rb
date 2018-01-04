class ChangeAdultToChild < ActiveRecord::Migration[5.0]
  def change
    remove_column :guests, :adult, :boolean
    add_column :guests, :child, :boolean
  end
end

