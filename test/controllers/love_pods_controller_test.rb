require "test_helper"

class LovePodsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get love_pods_new_url
    assert_response :success
  end

  test "should get create" do
    get love_pods_create_url
    assert_response :success
  end

  test "should get show" do
    get love_pods_show_url
    assert_response :success
  end

  test "should get edit" do
    get love_pods_edit_url
    assert_response :success
  end

  test "should get update" do
    get love_pods_update_url
    assert_response :success
  end

  test "should get destroy" do
    get love_pods_destroy_url
    assert_response :success
  end
end
