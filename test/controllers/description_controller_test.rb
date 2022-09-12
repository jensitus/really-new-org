require "test_helper"

class DescriptionControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get description_new_url
    assert_response :success
  end

  test "should get create" do
    get description_create_url
    assert_response :success
  end

  test "should get update" do
    get description_update_url
    assert_response :success
  end

  test "should get delete" do
    get description_delete_url
    assert_response :success
  end
end
