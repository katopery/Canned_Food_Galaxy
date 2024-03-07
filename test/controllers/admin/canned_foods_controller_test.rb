require "test_helper"

class Admin::CannedFoodsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_canned_foods_index_url
    assert_response :success
  end

  test "should get new" do
    get admin_canned_foods_new_url
    assert_response :success
  end

  test "should get create" do
    get admin_canned_foods_create_url
    assert_response :success
  end

  test "should get show" do
    get admin_canned_foods_show_url
    assert_response :success
  end

  test "should get edit" do
    get admin_canned_foods_edit_url
    assert_response :success
  end

  test "should get search" do
    get admin_canned_foods_search_url
    assert_response :success
  end

  test "should get update" do
    get admin_canned_foods_update_url
    assert_response :success
  end
end
