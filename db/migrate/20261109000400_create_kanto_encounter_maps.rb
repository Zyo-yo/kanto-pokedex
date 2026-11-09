class CreateKantoEncounterMaps < ActiveRecord::Migration[8.1]
  def change
    create_table :kanto_locations do |t|
      t.string :identifier, null: false, index: { unique: true }
      t.string :name, null: false
      t.json :map_cells, null: false, default: []
      t.timestamps
    end

    create_table :kanto_encounters do |t|
      t.references :pokemon, null: false, foreign_key: { to_table: :pokemon }
      t.references :kanto_location, null: false, foreign_key: true
      t.string :game_version, null: false
      t.string :encounter_method, null: false
      t.timestamps
      t.index [:pokemon_id, :kanto_location_id, :game_version, :encounter_method], unique: true
    end
  end
end
