require "test_helper"

class PhotoGalleriesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    sign_in users(:one)
    @photo_gallery = photo_galleries(:one)
  end

  test "should get index" do
    get photo_galleries_url
    assert_response :success
  end

  test "should get new" do
    get new_photo_gallery_url
    assert_response :success
  end

  test "should create photo_gallery" do
    assert_difference("PhotoGallery.count") do
      post photo_galleries_url, params: { photo_gallery: { description: @photo_gallery.description, last_updated_by_id: @photo_gallery.last_updated_by_id, title: @photo_gallery.title } }
    end
    assert_redirected_to photo_gallery_url(PhotoGallery.last)
  end

  test "should show photo_gallery" do
    get photo_gallery_url(@photo_gallery)
    assert_response :success
  end

  test "should get edit" do
    photo_gallery = users(:one).photo_galleries.create!(title: @photo_gallery.title, description: @photo_gallery.description, last_updated_by_id: users(:one))
    get edit_photo_gallery_url(photo_gallery)
    assert_response :success
  end

  test "should update photo_gallery" do
    photo_gallery = users(:one).photo_galleries.create!(title: @photo_gallery.title, description: @photo_gallery.description, last_updated_by_id: users(:one))
    patch photo_gallery_url(photo_gallery), params: { photo_gallery: { description: @photo_gallery.description, last_updated_by_id: @photo_gallery.last_updated_by_id, title: @photo_gallery.title } }
    assert_redirected_to photo_gallery_url(photo_gallery)
  end

  test "should destroy photo_gallery" do
    photo_gallery = users(:one).photo_galleries.create!(title: @photo_gallery.title, description: @photo_gallery.description, last_updated_by_id: users(:one))
    assert_difference("PhotoGallery.count", -1) do
      delete photo_gallery_url(photo_gallery)
    end

    assert_redirected_to photo_galleries_url
  end
end
