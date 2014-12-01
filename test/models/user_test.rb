require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "get user's all groups ancestors" do
  	user = User.find(1)
  	user.groups << Group.find(2)
  	user.groups << Group.find(4)
  	user.groups << Group.find(6)

  	ancestor_groups = []
  	user.groups.each do |group|
  		ancestor = group.ancestor
  		ancestor_groups << ancestor if not ancestor_groups.include? ancestor 
  	end
  	assert_equal 2, ancestor_groups.size
  end
end
