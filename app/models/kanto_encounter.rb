class KantoEncounter < ApplicationRecord
  GAME_NAMES = { "firered" => "FireRed", "leafgreen" => "LeafGreen" }.freeze

  belongs_to :pokemon
  belongs_to :kanto_location

  validates :game_version, inclusion: { in: GAME_NAMES.keys }
  validates :encounter_method, presence: true, uniqueness: { scope: [:pokemon_id, :kanto_location_id, :game_version] }
end
