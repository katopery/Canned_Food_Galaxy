require "test_helper"

class Public::CannedFoodsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get public_canned_foods_index_url
    assert_response :success
  end

  test "should get search" do
    get public_canned_foods_search_url
    assert_response :success
  end

  test "should get show" do
    get public_canned_foods_show_url
    assert_response :success
  end
end
