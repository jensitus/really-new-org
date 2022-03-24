require "test_helper"

class PhotosControllerTest < ActionDispatch::IntegrationTest
  test "should get destroy" do
    get photos_destroy_url
    assert_response :success
  end

  test "should get show" do
    get photos_show_url
    assert_response :success
  end
end
