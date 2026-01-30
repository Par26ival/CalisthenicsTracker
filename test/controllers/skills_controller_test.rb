require "test_helper"

class SkillsControllerTest < ActionDispatch::IntegrationTest
  test "should redirect to login when not authenticated" do
    get skills_url
    assert_redirected_to login_path
  end

  test "should get index when authenticated" do
    sign_in users(:user)
    get skills_url
    assert_response :success
  end

  test "should redirect to login for show when not authenticated" do
    skill = skills(:one)
    get skill_url(skill)
    assert_redirected_to login_path
  end
end
