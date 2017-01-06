class PokemonBattle < ApplicationRecord
	STATE = ['Ongoing', 'Finished']
	BATTLE_TYPE = [
		"Me vs Me",
		"Me vs AI",
		"AutoMatch!"]

	belongs_to :pokemon1, class_name: 'Pokemon'
	belongs_to :pokemon2, class_name: 'Pokemon'

	has_many :pokemon_battle_logs, dependent: :destroy

	validates :pokemon1_id, presence: true
	validates :pokemon2_id, presence: true
	validates :pokemon1_max_health_point, presence: true,numericality: {	only_integer: true, greater_than: 0}
	validates :pokemon2_max_health_point, presence: true, numericality: {
			only_integer: true, greater_than: 0}
	validates :battle_type, presence: true, inclusion: {in: BATTLE_TYPE}
	validates :state, presence: true, inclusion: {in: STATE}
	validates :current_turn, presence: true, numericality: { only_integer: true, greater_than: 0}
	validate :check_pokemon1_and_pokemon2
	validate :check_pokemon_hp_zero

end
