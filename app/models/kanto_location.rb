require "json"

class KantoLocation < ApplicationRecord
  ARTWORK_POINTS = JSON.parse(Rails.root.join("config/kanto_artwork_points.json").read).freeze

  has_many :kanto_encounters, dependent: :destroy

  validates :identifier, presence: true, uniqueness: true
  validates :name, presence: true
  validate :cells_fit_map

  def artwork_point
    ARTWORK_POINTS[identifier]
  end

  private

  def cells_fit_map
    valid = map_cells.is_a?(Array) && map_cells.all? do |cell|
      cell.is_a?(Array) && cell.size == 2 && (0...22).cover?(cell[0]) && (0...15).cover?(cell[1]) &&
        cell.all?(Integer)
    end
    errors.add(:map_cells, "must contain valid Kanto grid coordinates") unless valid
  end
end
