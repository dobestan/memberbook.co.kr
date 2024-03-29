class GroupController < ApplicationController
	layout "product"
	
	# GET /:group_code/:group_id/users
	# group code 는 학교 단위 ( 즉, 최상위 그룹 )
	# group id 는 학교 내부 집단 단위
	def users
		yaml = YAML.load(File.open("#{Rails.root}/config/secrets.yml"))[Rails.env]
    key = "memberbook_key_#{params[:group_code]}"
    accessKey = yaml[key].to_s

		keyFromClient = cookies[:access_token]
		md5 = Digest::MD5.new
		keyInput = md5.update("#{keyFromClient}_#{yaml['hash_token']}").to_s

		# puts "keyFromClient: #{keyFromClient}"
		# puts "keyInput: #{keyInput}"
		# puts "accessKey: #{accessKey}"

		# puts "accessKey == keyInput #{accessKey == keyInput}"

		if accessKey == keyInput
			@group = Group.find(params[:group_id])
			@users = @group.users
		end

		respond_to do |format|
			format.js { render :partial => "dashboard/users" }
			format.json { render json: @users }
		end
	end

	# GET /:group_code/users
	# group code 는 학교 단위 ( 즉, 최상위 그룹 )
	# group id 는 학교 내부 집단 단위
	def all_users
		yaml = YAML.load(File.open("#{Rails.root}/config/secrets.yml"))[Rails.env]
    key = "memberbook_key_#{params[:group_code]}"
    accessKey = yaml[key].to_s

		keyFromClient = cookies[:access_token]
		md5 = Digest::MD5.new
		keyInput = md5.update("#{keyFromClient}_#{yaml['hash_token']}").to_s

		if accessKey == keyInput
			@group = Group.find_by_code(params[:group_code]).ancestor
			@users = @group.descendents_users
		end

		respond_to do |format|
			# format.js { render :partial => "dashboard/users" }
			format.json { render json: @users }
		end
	end

	# POST /:group_code/:groud_id/groups
	# 학교 ( group_code ) 에 해당 그룹 ( group_id ) 의 서브그룹으로 추가
	def create
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

	# DELETE /groups/:group_id
	# group_id 에 해당 그룹 삭제
	def destroy
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

	# PUT /groups/:group_id
	# group_id 에 해당 그룹 수정
	def update
		@group = Group.find(params[:group_id])

		respond_to do |format|
			if @group.update({name: params[:group_name]})
				format.json { render json: @group }
			else
				format.json { render plain: "fail" }
			end
		end
	end

	# GET /:group_code/intro
	def intro
		@group = Group.find_by_code(params[:group_code])
	end

	# GET /:group_code/howto
	def howto
	end
end