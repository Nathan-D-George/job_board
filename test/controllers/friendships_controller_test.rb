require "test_helper"

class FriendshipsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get friendships_create_url
    assert_response :success
  end

  test "should get delete" do
    get friendships_delete_url
    assert_response :success
  end
end
