class PokemonBattlesController < ApplicationController

	def index
		@pokemon_battles = PokemonBattle.all
	end

	def new
		@pokemon_battle = PokemonBattle.new
		new_pokemon_battle
	end

	def create
		@pokemon_battle = PokemonBattle.new(pokemon_battle_params)
		get_each_pokemon
		set_pokemon_battle_attr
		if @pokemon_battle.save
			if @pokemon_battle.battle_type == "AutoMatch!"
				redirect_to pokemon_battle_auto_battle_path(@pokemon_battle)
			else
				redirect_to @pokemon_battle
			end
		else
			@list_pokemons = Pokemon.all.map { |poke| [poke.name, poke.id] }
			render 'new'
		end
	end

	def destroy
		@pokemon_battle = PokemonBattle.find(params[:id])
		@pokemon_battle.destroy
		redirect_to pokemon_battles_path
	end

	def show
		@pokemon_battle = PokemonBattle.find(params[:id])
		@pokemon_battle_logs = @pokemon_battle.pokemon_battle_logs
		get_each_pokemon
	end

	def attack
		@pokemon_battle = PokemonBattle.find(params[:pokemon_battle_id])
		if @pokemon_battle.battle_type == "Me vs Me"
			manual_attack
		elsif @pokemon_battle.battle_type == "Me vs Comp"
			ai_attack
		end
	end

	def auto_battle
		@pokemon_battle = PokemonBattle.find(params[:pokemon_battle_id])
		pokemon_auto_engine
	end

	def surrender
		@pokemon_battle = PokemonBattle.find(params[:pokemon_battle_id])
		manual_surrender
	end

	private

	def pokemon_battle_params
		params.require(:pokemon_battle).permit(:pokemon1_id, :pokemon2_id, :battle_type)
	end

	def manual_attack
		pokemon_battle_engine = PokemonBattleEngine.new(pokemon_battle: @pokemon_battle,attacker_id: params[:attacker_id],	skill_id: params[:skill_id])
		if pokemon_battle_engine.list_attack_validations?
			pokemon_battle_engine.attack
			pokemon_battle_engine.save_attack
			redirect_to @pokemon_battle
		else
			get_each_pokemon
			render 'show'
		end
	end

	def ai_attack
		pokemon_battle_engine = PokemonBattleEngine.new(pokemon_battle: @pokemon_battle, attacker_id: @pokemon_battle.pokemon1_id, skill_id: params[:skill_id])
		if pokemon_battle_engine.list_attack_validations?
			pokemon_battle_engine.attack
			pokemon_battle_engine.save_attack
			pokemon_battle_ai_engine = CompBattleEngine.new(pokemon_battle: @pokemon_battle)
			pokemon_battle_ai_engine.begin_ai_battle
			redirect_to @pokemon_battle
		else
			get_each_pokemon
			render 'show'
		end
	end

	def manual_surrender
		pokemon_battle_engine = PokemonBattleEngine.new(pokemon_battle: @pokemon_battle,attacker_id: params[:surrender_id])
		if pokemon_battle_engine.list_surrender_validations?
			pokemon_battle_engine.surrender
			pokemon_battle_engine.save_surrender
			redirect_to @pokemon_battle
		else
			get_each_pokemon
			render 'show'
		end
	end

	def set_pokemon_battle_attr
		@pokemon_battle.current_turn = 1
		@pokemon_battle.state = "Ongoing"
		@pokemon_battle.pokemon1_max_health_point = @pokemon1.max_health_point
		@pokemon_battle.pokemon2_max_health_point = @pokemon2.max_health_point
	end

	def get_each_pokemon
		@pokemon1 = Pokemon.find(@pokemon_battle.pokemon1_id)
		@pokemon2 = Pokemon.find(@pokemon_battle.pokemon2_id)
	end

	def new_pokemon_battle
		@list_pokemons = []
		@pokemons = Pokemon.all
		@pokemons.each { |poke| @list_pokemons << [poke.name, poke.id] if poke.current_health_point > 0 }
		@list_battle_types = []
		PokemonBattle::BATTLE_TYPE.each { |type| @list_battle_types << [type, type]}
	end

	def pokemon_auto_engine
		auto_engine = AutoBattleEngine.new(pokemon_battle: @pokemon_battle)
		auto_engine.begin_auto_battle
		redirect_to @pokemon_battle
	end
end
