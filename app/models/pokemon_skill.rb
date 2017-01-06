class PokemonSkill < ApplicationRecord
	belongs_to :pokemon
	belongs_to :skill
	
	validates :skill_id, presence: true
	validates :pokemon_id, presence: true
	validates_uniqueness_of :skill_id, scope: :pokemon_id
	validates :current_pp,presence: true,	numericality: { only_integer: true, greater_than_or_equal_to: 0,less_than_or_equal_to: :skill_max_pp}

end
