class PagesController < ApplicationController
  
  def home
    @pokedexes = Pokedex.where(name: params[:name]).paginate(page: params[:page], per_page: 50)
  end

  def show
    @pokedexes = Pokedex.find(params[:id])
  end
end
