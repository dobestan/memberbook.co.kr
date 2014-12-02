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

	# GET /dashboard/:group_code/:group_id/users.json
	# group code 는 학교 단위 ( 즉, 최상위 그룹 )
	# group id 는 학교 내부 집단 단위
	def group_users
		@group = Group.find(params[:group_id])
		@users = @group.users

		respond_to do |format|
			format.json { render json: @users }
		end
	end

	# POST /dashboard/:group_code/:groud_id/groups
	# 학교 ( group_code ) 에 해당 그룹 ( group_id ) 의 서브그룹으로 추가
	def createGroup
		@group = Group.create({
			name: params[:name],
			code: params[:group_code],
			parent_id: params[:group_id],
			level: params[:group_level].to_i + 1
		});

		respond_to do |format|
			if @group.save
				format.json { render json: @group }
			else
				format.json { render plain: "fail" }
			end
		end
	end

	# DELETE /dashboard/groups/:group_id
	# group_id 에 해당 그룹 삭제
	def destroyGroup
		@group = Group.find(params[:group_id]);
		@group.destroy

		respond_to do |format|
			if @group.destroyed?
				format.json { render plain: "success" }
			else
				format.json { render plain: "fail" }
			end
		end
	end

	# PUT /dashboard/groups/:group_id
	# group_id 에 해당 그룹 수정
	def updateGroup
		@group = Group.find(params[:group_id])

		respond_to do |format|
			if @group.update({name: params[:group_name]})
				format.json { render json: @group }
			else
				format.json { render plain: "fail" }
			end
		end
	end

	# GET /dashboard/:group_id/users
	def users
		@group = Group.find_by! code: params[:group_code]
		@users = @group.descendents_users
		
		respond_to do |format|
			format.json { render json: @users }
		end
	end

	# DELETE /dashboard/users/:user_id
	# group_id 에 해당 그룹 삭제
	def destroyUser
		@user = User.find(params[:user_id]);
		@user.destroy

		respond_to do |format|
			if @user.destroyed?
				format.json { render plain: "success" }
			else
				format.json { render plain: "fail" }
			end
		end
	end
end