class DashboardController < ApplicationController
	# GET /dashboard
	def index
		# @groups = Group.all
		# @users = @groups.first.users
		@user = User.find(1)
		@ancestor_groups = []
		@user.groups.each do |group|
			ancestor = group.ancestor
			@ancestor_groups << ancestor if not @ancestor_groups.include? ancestor
		end
		@users = @ancestor_groups.first.children.first.users
	end

	# GET /dashboard/{group_code}/{group_id}/users.json
	# group code 는 학교 단위 ( 즉, 최상위 그룹 )
	# group id 는 학교 내부 집단 단위
	def users
		@group = Group.find(params[:group_id])
		@users = @group.users

		respond_to do |format|
			format.json { render json: @users }
		end
	end
end