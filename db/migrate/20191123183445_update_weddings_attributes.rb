class UpdateWeddingsAttributes < ActiveRecord::Migration[5.2]
  def change
    add_column :weddings, :first_name_1, :string
    add_column :weddings, :first_name_2, :string

    remove_column :weddings, :spouse_first_name, :string
    remove_column :weddings, :spouse_last_name, :string
    remove_column :weddings, :capacity, :integer
    remove_column :weddings, :title, :string
  end
end
