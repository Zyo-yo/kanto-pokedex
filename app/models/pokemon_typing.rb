class PokemonTyping < ApplicationRecord
  belongs_to :pokemon, inverse_of: :pokemon_typings
  belongs_to :elemental_type, inverse_of: :pokemon_typings

  validates :slot, inclusion: { in: [1, 2] }, uniqueness: { scope: :pokemon_id }
  validates :elemental_type_id, uniqueness: { scope: :pokemon_id }
end
