require 'test_helper'

class GroupTest < ActiveSupport::TestCase
  setup do
  	@EMBA = Group.create(:name => "EMBA")
  end


  test "create object" do
  	assert_equal "EMBA", @EMBA.name
  end

  test "get immedate children" do
  	architect = Group.create(:name => "architect", :parent => @EMBA)
  	art = Group.create(:name => "art", :parent => @EMBA)
  	assert_equal @EMBA.descendents, [architect, art]
  end

  test "get immedate children including self" do
  	architect = Group.create(:name => "architect", :parent => @EMBA)
  	art = Group.create(:name => "art", :parent => @EMBA)
  	assert_equal @EMBA.self_and_descendents, [@EMBA, architect, art]
  end

  test "add users to group" do
    groups = Group.all    
    groups.first.users << User.all

    assert_equal 2, groups.first.users.size

    # 그룹에 유저 추가
    groups.first.users.create({
      name: '김민혁',
      phone_number: '010-2220-5736',
      email: 'dobestan@gmail.com',
      profile_img_name: 'suchan.png',
      grade: '2학년',
      address: '서울시 관악구 낙성대동',
      birthday: '1993-5-1'
    })

    assert_equal 3, groups.first.users.size
  end

  test "update group" do
    group = Group.find(2);
    group.update({name: "건설경제"})
    # 이름이 잘 변경되었는가?
    assert_equal "건설경제", group.name
    # 다른 칼럼값은 유지되는가?
    assert_equal 20000, group.point
  end

  test "get all users using group_code" do
    group = Group.find(2)
    group.users << User.all
    ancestor_group = group.ancestor
    assert_equal 2, ancestor_group.descendents_users.size
  end
end