class SkillsController < ApplicationController

	def index
		@skills = Skill.all
    navigation_add("Skill Index", "#")
	end

end
