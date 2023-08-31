require "test_helper"

class CompaniesControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get companies_new_url
    assert_response :success
  end

  test "should get create" do
    get companies_create_url
    assert_response :success
  end

  test "should get show" do
    get companies_show_url
    assert_response :success
  end

  test "should get edit" do
    get companies_edit_url
    assert_response :success
  end

  test "should get update" do
    get companies_update_url
    assert_response :success
  end

  test "should get delete" do
    get companies_delete_url
    assert_response :success
  end

  test "should get search" do
    get companies_search_url
    assert_response :success
  end

  test "should get results" do
    get companies_results_url
    assert_response :success
  end
end
