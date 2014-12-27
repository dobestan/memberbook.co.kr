require 'test_helper'

class UserTest < ActiveSupport::TestCase
  require 'csv'
  require 'find'
  require 'fileutils'
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
    end
  end

  test "read data to array" do
    CSV.foreach('test/users_sub.csv', headers: true) do |row|
      user = row.to_hash
      # puts user["student_number"]
    end
  end

  test "traverse files" do
    CSV.foreach('db/seeds/emba_users_96.csv', headers: true) do |row|
      user = row.to_hash    

      dir = "/Users/jehyeok/Desktop/멤버북/원우 사진/96기 사진"
      dest_dir = "/Users/jehyeok/Desktop/멤버북/원우 사진 최종/96기 사진"
      changeFileName(dir, dest_dir, user)
    end
    CSV.foreach('db/seeds/emba_users_95.csv', headers: true) do |row|
      user = row.to_hash    

      dir = "/Users/jehyeok/Desktop/멤버북/원우 사진/95기 사진"
      dest_dir = "/Users/jehyeok/Desktop/멤버북/원우 사진 최종/95기 사진"
      changeFileName(dir, dest_dir, user)
    end
    CSV.foreach('db/seeds/emba_users_94.csv', headers: true) do |row|
      user = row.to_hash    

      dir = "/Users/jehyeok/Desktop/멤버북/원우 사진/94기 사진"
      dest_dir = "/Users/jehyeok/Desktop/멤버북/원우 사진 최종/94기 사진"
      changeFileName(dir, dest_dir, user)
    end
    CSV.foreach('db/seeds/emba_users_93.csv', headers: true) do |row|
      user = row.to_hash    

      dir = "/Users/jehyeok/Desktop/멤버북/원우 사진/93기 사진"
      dest_dir = "/Users/jehyeok/Desktop/멤버북/원우 사진 최종/93기 사진"
      changeFileName(dir, dest_dir, user)
    end
  end

  def changeFileName(from_dir, to_dir, key)
    FileUtils.mkdir_p((to_dir));
    Find.find(from_dir) do |f|
      if (File.basename(f).include? key["student_number"])
        puts key["student_number"]
        puts key["phone_number"]
        contents = File.read(f)
        File.write("#{to_dir}/#{key["phone_number"]}.png", contents)
      end
    end
  end
end