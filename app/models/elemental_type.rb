class ElementalType < ApplicationRecord
  has_many :pokemon_typings, dependent: :destroy, inverse_of: :elemental_type
  has_many :pokemon, through: :pokemon_typings, source: :pokemon

  validates :source_id, uniqueness: true, numericality: { only_integer: true, greater_than: 0 }
  validates :identifier, presence: true, uniqueness: true

  def display_name
    identifier.titleize
  end
end
