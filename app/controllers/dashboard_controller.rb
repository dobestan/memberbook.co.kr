class DashboardController < ApplicationController
	# GET /dashboard
	def index
		@user = User.find(1)
		@ancestor_groups = []
		@user.groups.each do |group|
			ancestor = group.ancestor
			@ancestor_groups << ancestor if not @ancestor_groups.include? ancestor
		end
		@users = @ancestor_groups.first.children.first.users
	end
end