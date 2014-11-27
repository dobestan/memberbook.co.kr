class DashboardController < ApplicationController
	# GET /dashboard
	def index
		@groups = Group.all
		@users = @groups.first.users
	end
end