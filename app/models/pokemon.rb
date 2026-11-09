class Pokemon < ApplicationRecord
  self.table_name = "pokemon"

  has_many :pokemon_typings, -> { order(:slot) }, dependent: :destroy, inverse_of: :pokemon
  has_many :elemental_types, through: :pokemon_typings
  has_many :kanto_encounters, dependent: :destroy

  validates :dex_number, uniqueness: true, numericality: { only_integer: true, greater_than: 0 }
  validates :identifier, presence: true, uniqueness: true
  validates :height_dm, :weight_hg, numericality: { only_integer: true, greater_than: 0 }
  validates :base_experience, numericality: { only_integer: true, greater_than_or_equal_to: 0 }, allow_nil: true

  def display_name
    identifier.tr("-", " ").titleize
  end
end
