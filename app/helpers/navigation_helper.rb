module NavigationHelper
	
	def ensure_navigation
		@navigation ||= []
	end

	def render_navigation
		render :partial => 'shared/navigation', :locals => { :nav => ensure_navigation}
	end
end
