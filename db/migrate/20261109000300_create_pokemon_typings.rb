class CreatePokemonTypings < ActiveRecord::Migration[8.1]
  def change
    create_table :pokemon_typings do |t|
      t.references :pokemon, null: false, foreign_key: { to_table: :pokemon }
      t.references :elemental_type, null: false, foreign_key: true
      t.integer :slot, null: false
      t.timestamps
    end

    add_index :pokemon_typings, [:pokemon_id, :slot], unique: true
    add_index :pokemon_typings, [:pokemon_id, :elemental_type_id], unique: true
  end
end
