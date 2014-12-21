require 'test_helper'

class UserTest < ActiveSupport::TestCase
  require 'csv'
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

  test "insert data from csv" do
    CSV.foreach('test/users_sub.csv', headers: true) do |row|
      user = User.create row.to_hash
      user.save!
      puts user.inspect
    end
  end
end