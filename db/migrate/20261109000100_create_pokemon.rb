class CreatePokemon < ActiveRecord::Migration[8.1]
  def change
    create_table :pokemon do |t|
      t.integer :dex_number, null: false
      t.string :identifier, null: false
      t.integer :height_dm, null: false
      t.integer :weight_hg, null: false
      t.integer :base_experience
      t.timestamps
    end

    add_index :pokemon, :dex_number, unique: true
    add_index :pokemon, :identifier, unique: true
  end
end
