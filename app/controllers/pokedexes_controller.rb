class PokedexesController < ApplicationController
	def index
		@pokedexes = Pokedex.all
	end
end
