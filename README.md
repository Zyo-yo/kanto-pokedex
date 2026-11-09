# Kanto Pokédex

A Ruby on Rails course project for browsing the original 151 Pokémon, searching their names, and exploring their elemental types.

## Run the project

Open a terminal in this folder. With Ruby 3.2 or newer and Bundler available, run:

```sh
bundle install
ruby bin/rails db:prepare
ruby bin/rails server
```

Open [localhost:3000](http://localhost:3000). The first database setup loads the bundled CSV files. To rerun the importer after setup, use `ruby bin/rails db:seed`. Bootstrap is bundled so the catalog can be demonstrated offline once the gems are installed.

## Walk through the code

1. **Schema.** Start in `db/migrate`. The first two migrations make the Pokémon and elemental type tables. The third makes the join table and constrains the foreign keys and type slots. The [ERD](public/erd.svg) shows how they connect.
2. **Models.** In `app/models`, each join record belongs to one Pokémon and one elemental type. Each parent has many join records. The `has_many :through` declarations make it possible to read either side directly.
3. **Import.** Read `db/seeds.rb` from top to bottom. It parses the three CSVs, saves the two parent collections, then looks up the CSV IDs to build join records with Rails IDs. The transaction rolls back on errors. Running it twice preserves an already-correct set of rows.
4. **Search.** Follow the root route in `config/routes.rb` to `PokemonController#index`. Rails filters by name and type, counts the matches, and fetches one page. The ERB template displays the matches or an empty state.
5. **Browse.** Open Charizard, click Flying, and click another Pokémon on the Flying page. The views use the Active Record associations to navigate in both directions.

## Dataset and schema

The About page documents the three local extracts from the [PokéAPI CSV collection](https://github.com/PokeAPI/pokeapi/tree/master/data/v2/csv). The expected import is 151 Pokémon, 17 elemental types, and 218 type memberships, for 386 rows total.

| CSV extract | Imported fields | Destination |
| --- | --- | --- |
| `pokemon.csv` | `id`, `identifier`, `height`, `weight`, `base_experience`. The extract is limited to default entries with IDs 1–151. | `pokemon`, with `dex_number`, `identifier`, `height_dm`, `weight_hg`, and nullable `base_experience` |
| `types.csv` | `id` and `identifier` for types used by the selected entries | `elemental_types`, with `source_id` and `identifier` |
| `pokemon_types.csv` | `pokemon_id`, `type_id`, and `slot` | `pokemon_typings`, with Rails foreign keys `pokemon_id` and `elemental_type_id`, plus `slot` |

Each table also has a Rails primary key and timestamps. Type data reflects the PokéAPI snapshot, so some classifications differ from the original games.

### Kanto encounter map

The seed also imports 72 locations and 1,399 distinct Pokémon, location, game version, and encounter method combinations for FireRed and LeafGreen. These extracts join PokéAPI's encounter, slot, method, version, area, and location CSVs. They collapse floors and encounter slots into named locations. The coordinate cells and schematic are derived from both layers of the [FireRed Kanto town-map grid](https://github.com/pret/pokefirered/blob/master/src/data/region_map/region_map_layout_kanto.h). Coordinates are zero-based column and row positions on its 22×15 grid. Areas outside this grid or without a verified section match are listed as unmapped.

## GitHub submission

The local history is on `master`. Create an empty GitHub repository, then run the following with its URL in place of the example:

```sh
git remote add origin https://github.com/YOUR-ACCOUNT/YOUR-REPO.git
git push -u origin master
```

Use the [marking checklist](MARKING.md) during your in-class demonstration.
