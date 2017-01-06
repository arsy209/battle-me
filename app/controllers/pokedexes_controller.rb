class PokedexesController < ApplicationController
	def index
		@pokedexes = Pokedex.all
	end

  def new
    @pokedex = Pokedex.new
    navigation_add("Pokedex Index", "#")
    navigation_add("Pokedex Index", pokedexes_path)
  end

  def create
  @pokedex = Pokedex.new(pokedex_params)
  if @pokedex.valid?
    @pokedex.save
    redirect_to pokedex_path(@pokedex)
  else
    render 'new'
  end
end

private

def pokedex_params
  params.require(:pokedex).permit(
    :name,
    :base_health_point,
    :base_attack,
    :base_defence,
    :base_speed,
    :element_type,
    :image_url
    )
end
end
