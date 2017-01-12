class HomeController < ApplicationController

  def index
    @pokedexes = Pokedex.where(element_type: params[:element_type])
  end

  def show
    @pokedexes = Pokedex.find(params[:id])
  end
end
