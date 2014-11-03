require 'test_helper'

class WelcomeControllerTest < ActionController::TestCase
  test "index should return 200" do
    get :index
    assert_response :success
  end
end
