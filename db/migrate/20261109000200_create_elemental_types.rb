class CreateElementalTypes < ActiveRecord::Migration[8.1]
  def change
    create_table :elemental_types do |t|
      t.integer :source_id, null: false
      t.string :identifier, null: false
      t.timestamps
    end

    add_index :elemental_types, :source_id, unique: true
    add_index :elemental_types, :identifier, unique: true
  end
end
