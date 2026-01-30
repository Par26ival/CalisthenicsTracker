require "test_helper"

class Admin::DashboardControllerTest < ActionDispatch::IntegrationTest
  test "should redirect to login when not authenticated" do
    get admin_dashboard_index_url
    assert_redirected_to login_path
  end

  test "should get index when authenticated as admin" do
    sign_in users(:admin)
    get admin_dashboard_index_url
    assert_response :success
  end
end
