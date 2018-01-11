class AddDeadlineToWedding < ActiveRecord::Migration[5.0]
  def change
    add_column :weddings, :deadline, :date
  end
end
