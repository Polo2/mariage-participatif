class AddGroupNameToRegistries < ActiveRecord::Migration[5.0]
  def change
    add_column :registries, :group_name, :string
  end
end
