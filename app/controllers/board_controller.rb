class BoardController < ApplicationController

	# POST /:group_code/boards
	# 학교 ( group_code ) 에 게시글 추가
	def create
		user = User.find(params[:user_id])
		# 유저가 등록되어 있는 ancestor_groups 추가
		@ancestor_groups = []
		user.groups.each do |group|
			ancestor = group.ancestor
			@ancestor_groups << ancestor if not @ancestor_groups.include? ancestor
		end

		group = Group.find_by_code(params[:group_code]).ancestor
		@board = Board.create({
			writer: user.name,
			title: params[:title],
			content: params[:content],
			count: 0,
			level: params[:level],
			group_id: group.id
		})

		respond_to do |format|
			if @board.save
				# format.json { render json: @board }
				format.js { render :partial => "dashboard/boards/list" }
			else
				format.json { render plain: "fail" }
			end
		end
	end
end