require "test_helper"

class FriendshipsControllerTest < ActionDispatch::IntegrationTest
  test "should redirect to login when not authenticated" do
    get friendships_create_url
    assert_redirected_to login_path
  end

  test "should redirect to login when not authenticated for accept" do
    get friendships_accept_url(id: 1)
    assert_redirected_to login_path
  end

  test "should redirect to login when not authenticated for decline" do
    delete friendships_decline_url(id: 1)
    assert_redirected_to login_path
  end
end
