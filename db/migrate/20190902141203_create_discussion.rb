class CreateDiscussion < ActiveRecord::Migration[5.2]
  def up
    create_table :discussions do |t|
      t.string :name
      t.references :wedding

      t.timestamps
    end

    remove_reference :messages, :task
    add_reference :messages, :resource, polymorphic: true
  end

  def down
    fail ActiveRecord::IrreversibleMigration
  end
end
