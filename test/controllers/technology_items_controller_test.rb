require "test_helper"

class TechnologyItemsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get technology_items_new_url
    assert_response :success
  end

  test "should get create" do
    get technology_items_create_url
    assert_response :success
  end

  test "should get edit" do
    get technology_items_edit_url
    assert_response :success
  end

  test "should get update" do
    get technology_items_update_url
    assert_response :success
  end

  test "should get destroy" do
    get technology_items_destroy_url
    assert_response :success
  end
end
