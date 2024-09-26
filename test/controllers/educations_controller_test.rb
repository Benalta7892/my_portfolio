require "test_helper"

class EducationsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get educations_index_url
    assert_response :success
  end

  test "should get show" do
    get educations_show_url
    assert_response :success
  end

  test "should get new" do
    get educations_new_url
    assert_response :success
  end

  test "should get create" do
    get educations_create_url
    assert_response :success
  end

  test "should get edit" do
    get educations_edit_url
    assert_response :success
  end

  test "should get update" do
    get educations_update_url
    assert_response :success
  end

  test "should get destroy" do
    get educations_destroy_url
    assert_response :success
  end
end
