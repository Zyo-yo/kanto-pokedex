require "csv"

def source_rows(filename)
  CSV.read(Rails.root.join("db", "data", filename), headers: true, encoding: "bom|utf-8")
end

pokemon_rows = source_rows("pokemon.csv").select do |row|
  row["is_default"] == "1" && (1..151).cover?(Integer(row.fetch("id"), 10))
end
raise "Expected the first 151 Pokémon" unless pokemon_rows.size == 151

kanto_ids = pokemon_rows.map { |row| row.fetch("id") }.to_set
typing_rows = source_rows("pokemon_types.csv").select { |row| kanto_ids.include?(row["pokemon_id"]) }
type_ids = typing_rows.map { |row| row.fetch("type_id") }.to_set
type_rows = source_rows("types.csv").select { |row| type_ids.include?(row["id"]) }
raise "Expected at least one type for every Pokémon" unless typing_rows.map { |row| row["pokemon_id"] }.to_set == kanto_ids

ApplicationRecord.transaction do
  pokemon_by_source_id = pokemon_rows.to_h do |row|
    source_id = row.fetch("id")
    pokemon = Pokemon.find_or_initialize_by(dex_number: source_id)
    pokemon.update!(
      identifier: row.fetch("identifier"),
      height_dm: row.fetch("height"),
      weight_hg: row.fetch("weight"),
      base_experience: row.fetch("base_experience")
    )
    [source_id, pokemon]
  end

  types_by_source_id = type_rows.to_h do |row|
    source_id = row.fetch("id")
    elemental_type = ElementalType.find_or_initialize_by(source_id: source_id)
    elemental_type.update!(identifier: row.fetch("identifier"))
    [source_id, elemental_type]
  end

  typing_rows.group_by { |row| row.fetch("pokemon_id") }.each do |source_id, rows|
    pokemon = pokemon_by_source_id.fetch(source_id)
    expected = rows.map { |row| [Integer(row.fetch("slot"), 10), types_by_source_id.fetch(row.fetch("type_id")).id] }
    current = pokemon.pokemon_typings.pluck(:slot, :elemental_type_id)
    next if current == expected.sort_by(&:first)

    pokemon.pokemon_typings.delete_all
    expected.each do |slot, elemental_type_id|
      pokemon.pokemon_typings.create!(slot: slot, elemental_type_id: elemental_type_id)
    end
  end
end

puts "Imported #{Pokemon.count} Pokémon, #{ElementalType.count} types, and #{PokemonTyping.count} typings."
