require 'test_helper'

class BoardTest < ActiveSupport::TestCase
  setup do
  	user = User.find(1)
  	@board = Board.create({
  			writer: user.name,
  			title: "제목입니다",
  			content: "<p>내용!!</p>",
  			count: 110,
  			level: 0
  		})
  	assert_equal 1, Board.all.size
  end

  test "add to group" do
    group = Group.find_by_code(0)
    assert_equal 0, group.boards.size
    group.boards << @board
    assert_equal 1, group.boards.size
  end
end
