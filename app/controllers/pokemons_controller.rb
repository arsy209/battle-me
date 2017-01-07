class PokemonsController < ApplicationController

  def index
    @pokemons = Pokemon.all
    navigation_add("Pokemon Index", "#")
  end

  def new
    @pokemon = Pokemon.new
    list_pokedexes = Pokedex.all
    @list_names_ids = list_pokedexes.map { |poke| [poke.name, poke.id]}
    navigation_add("Pokemon Index", pokemons_path)
    navigation_add("Pokemon New", "#")
  end
end
