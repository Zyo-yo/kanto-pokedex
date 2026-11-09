class ElementalTypesController < ApplicationController
  def index
    @types = ElementalType.order(:identifier)
  end

  def show
    @type = ElementalType.find(params[:id])
    @pokemon = @type.pokemon.includes(:elemental_types).order(:dex_number)
  end
end
