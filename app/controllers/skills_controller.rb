class SkillsController < ApplicationController

	def index
		@skills = Skill.paginate(page: params[:page], per_page: 70)
		@skill = Skill.new
	end

	def new
		@skill = Skill.new
	end

	def create
		@skill = Skill.new(skill_params)
		if @skill.save
			redirect_to @skill
		else
			render 'new'
		end
	end

	def edit
		@skill = Skill.find(params[:id])
	end

	def update
		@skill = Skill.find(params[:id])
		@skill.update(skill_params)
		if @skill.save
			redirect_to @skill
		else
			render 'edit'
		end
	end

	def show
		@skill = Skill.find(params[:id])
	end

	def destroy
		@skill = Skill.find(params[:id])
		@skill.destroy
		redirect_to skills_path
	end

	private

	def skill_params
		params.require(:skill).permit(:name, :power, :max_pp, :element_type)
	end
end
