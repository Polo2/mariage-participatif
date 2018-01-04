class ChangeTypeOfDateForService < ActiveRecord::Migration[5.0]
  def change
    remove_column :services, :creneau
    add_column :services, :appointment, :string
  end
end
