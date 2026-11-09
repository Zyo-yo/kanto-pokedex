class PokemonController < ApplicationController
  PAGE_SIZE = 24

  def index
    filters = params.permit(:q, :elemental_type_id, :page)
    @query = filters[:q].to_s.strip
    @type_id = filters[:elemental_type_id].presence
    @types = ElementalType.order(:identifier)
    results = Pokemon.order(:dex_number)

    if @query.present?
      name = Pokemon.sanitize_sql_like(@query.downcase.tr(" ", "-"))
      results = results.where("LOWER(pokemon.identifier) LIKE ?", "%#{name}%")
    end
    if @type_id
      results = results.joins(:pokemon_typings).where(pokemon_typings: { elemental_type_id: @type_id })
    end

    @total = results.count
    @page_count = [(@total + PAGE_SIZE - 1) / PAGE_SIZE, 1].max
    @page = filters[:page].to_s.to_i.clamp(1, @page_count)
    @pokemon = results.includes(:elemental_types).limit(PAGE_SIZE).offset((@page - 1) * PAGE_SIZE)
  end

  def show
    @pokemon = Pokemon.includes(pokemon_typings: :elemental_type).find(params[:id])
  end
end
