require "test_helper"

class EnlistmentsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get enlistments_new_url
    assert_response :success
  end

  test "should get create" do
    get enlistments_create_url
    assert_response :success
  end

  test "should get destroy" do
    get enlistments_destroy_url
    assert_response :success
  end
end
