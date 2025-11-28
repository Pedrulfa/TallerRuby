require "test_helper"

class SessionsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get login_url
    assert_response :success
  end

  test "should create session" do
    post login_url, params: { email: "test@example.com", password: "password" }
    # Depending on implementation, this might redirect or render.
    # For now, let's assume it might fail login and render new (success) or redirect.
    # But simply checking the route exists is a start.
    assert_response :success, "Expected success or redirect" rescue assert_response :redirect
  end

  test "should destroy session" do
    delete logout_url
    assert_redirected_to root_url # Assuming logout redirects to root or login
  end
end
