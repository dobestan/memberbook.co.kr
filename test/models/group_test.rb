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
  	puts @EMBA.descendents.inspect
  	assert_equal @EMBA.descendents, [architect, art]
  end

  test "get immedate children including self" do
  	architect = Group.create(:name => "architect", :parent => @EMBA)
  	art = Group.create(:name => "art", :parent => @EMBA)
  	puts @EMBA.descendents.inspect
  	assert_equal @EMBA.self_and_descendents, [@EMBA, architect, art]
  end
end