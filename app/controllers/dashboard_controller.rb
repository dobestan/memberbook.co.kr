class DashboardController < ApplicationController
	# GET /dashboard
	def index
		user = User.find(1)
		@ancestor_groups = []
		user.groups.each do |group|
			ancestor = group.ancestor
			@ancestor_groups << ancestor if not @ancestor_groups.include? ancestor
		end
		@users = @ancestor_groups.first.children.first.users
		@ancestor_group = @ancestor_groups.first

		@boards = @ancestor_group.boards
		boards_size = @boards.size
		@boards = @boards.limit(10).order(id: :desc)
		last_page_num = boards_size == 0 ? 1 : ((( boards_size - 1 ) / 10) + 1)
		@active_page_num = 1
		@page_nums = (1..(last_page_num)).to_a
		@page_nums.slice!(10)
	end
end