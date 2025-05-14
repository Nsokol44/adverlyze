require "test_helper"

class AdsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get ads_index_url
    assert_response :success
  end

  test "should get show" do
    get ads_show_url
    assert_response :success
  end

  test "should get new" do
    get ads_new_url
    assert_response :success
  end

  test "should get create" do
    get ads_create_url
    assert_response :success
  end

  test "should get edit" do
    get ads_edit_url
    assert_response :success
  end

  test "should get update" do
    get ads_update_url
    assert_response :success
  end

  test "should get destroy" do
    get ads_destroy_url
    assert_response :success
  end
end
