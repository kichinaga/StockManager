require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  test "should get login_form" do
    get sessions_login_form_url
    assert_response :success
  end

end
