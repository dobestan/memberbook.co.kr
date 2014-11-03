require 'test_helper'

class WelcomeControllerTest < ActionController::TestCase
  test "index should return 200" do
    get :index
    assert_response :success
  end

  test "help should return 404" do
    # failing test
    get :about
    assert_response :missing #404
  end
end
