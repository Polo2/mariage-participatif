class DropAttachinaryFiles < ActiveRecord::Migration[5.2]
  def up
    drop_table :attachinary_files
  end

  def down
        create_table :attachinary_files do |t|
      t.references :attachinariable, polymorphic: true, index: {:name => "attachinariable_index_name"}
      t.string :scope
      t.string :public_id
      t.string :version
      t.integer :width
      t.integer :height
      t.string :format
      t.string :resource_type
      t.timestamps
    end
    add_index :attachinary_files, [:attachinariable_type, :attachinariable_id, :scope], name: 'by_scoped_parent'
  end
end
