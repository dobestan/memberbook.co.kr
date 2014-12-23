class BoardController < ApplicationController
	layout "product"
	# POST /:group_code/boards
	# 학교 ( group_code ) 에 게시글 추가
	def create
		user = User.find(params[:user_id])
		# 유저가 등록되어 있는 ancestor_groups 추가
		@ancestor_group = Group.find_by_code(params[:group_code]).ancestor
		@board = Board.create({
			writer: user.name,
			title: params[:title],
			content: params[:content],
			count: 0,
			level: params[:level],
			group_id: @ancestor_group.id
		})

		@boards = @ancestor_group.boards
		boards_size = @boards.size
		@boards = @boards.limit(10).order(id: :desc)
		last_page_num = boards_size == 0 ? 1 : ((( boards_size - 1 ) / 10) + 1)
		@page_nums = (1..(last_page_num)).to_a
		@page_nums.slice!(10)
		@active_page_num = 1

		respond_to do |format|
			if @board.save
				format.js { render :partial => "dashboard/boards/list" }
			else
				format.json { render plain: "fail" }
			end
		end
	end

	# GET /:group_code/boards
	# 학교 ( group_code ) 게시글 불러오기
	def boards
		yaml = YAML.load(File.open("#{Rails.root}/config/secrets.yml"))[Rails.env]
    key = "memberbook_key_#{params[:group_code]}"
    accessKey = yaml[key].to_s

		keyFromClient = cookies[:access_token]
		md5 = Digest::MD5.new
		keyInput = md5.update("#{keyFromClient}_#{yaml['hash_token']}").to_s

		puts "keyFromClient: #{keyFromClient}"
		puts "keyInput: #{keyInput}"
		puts "accessKey: #{accessKey}"

		puts "accessKey == keyInput #{accessKey == keyInput}"

		if accessKey == keyInput
			@ancestor_group = Group.find_by_code(params[:group_code]).ancestor
			@boards = @ancestor_group.boards
			boards_size = @boards.size
			# 클릭한 페이지 번호
			page_num = params[:page_num].to_i
			# 가능한 마지막 페이지 번호
			last_page_num = boards_size == 0 ? 1 : ((( boards_size - 1 ) / 10) + 1)
			puts "last_page_num: #{last_page_num}"
			if page_num > last_page_num
				@active_page_num = last_page_num
			else
				@active_page_num = page_num
			end
			@active_page_num = @active_page_num == 0 ? 1 : @active_page_num

			puts "@active_page_num: #{@active_page_num}"
			@page_nums = []

			if @active_page_num - 5 < 1
				@page_nums = (1..last_page_num).to_a
			else
				@page_nums = ((@active_page_num - 5)..last_page_num).to_a
			end
			@page_nums.slice!(10)
			# 게시글 페이지 전환 시 게시글 오프셋

			@offset_board_num = (@active_page_num - 1) * 10
			@boards = @boards.offset(@offset_board_num).limit(10).order(id: :desc)

			respond_to do |format|
				format.js { render :partial => "dashboard/boards/list" }
				format.json { render json: @boards }
			end
		end
	end

	# GET /:group_code/boards/:board_id
	# 학교 ( group_code ) 게시글 불러오기
	def show
		@board = Board.find(params[:board_id])
		@board.count += 1
		respond_to do |format|
			if @board.save
				format.json { render json: @board }
				format.html { render "product/board" }
			else
				format.json { render plain: "fail"}
			end
		end
	end
end