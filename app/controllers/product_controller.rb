class ProductController < ApplicationController
	# GET /product
	# 로그인한 유저의 쿠키 정보를 이용해 그룹을 받아옴
	# or 출시한 앱에 그룹 코드를 넣어둠
	def index
		group_code = 0
		group = Group.find_by_code(0).ancestor
		@groups = group.descendents

		respond_to do |format|
			format.html
		end
	end

	# GET /product/boards
	def boards
		group_code = 0
		group = Group.find_by_code(0).ancestor
		@boards = group.boards

		respond_to do |format|
			format.html { render :partial => "product/boards" }
		end
	end
end