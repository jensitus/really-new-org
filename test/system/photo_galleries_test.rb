require "application_system_test_case"

class PhotoGalleriesTest < ApplicationSystemTestCase
  setup do
    @photo_gallery = photo_galleries(:one)
  end

  test "visiting the index" do
    visit photo_galleries_url
    assert_selector "h1", text: "Photo galleries"
  end

  test "should create photo gallery" do
    visit photo_galleries_url
    click_on "New photo gallery"

    fill_in "Description", with: @photo_gallery.description
    fill_in "Last updated by", with: @photo_gallery.last_updated_by_id
    fill_in "Title", with: @photo_gallery.title
    click_on "Create Photo gallery"

    assert_text "Photo gallery was successfully created"
    click_on "Back"
  end

  test "should update Photo gallery" do
    visit photo_gallery_url(@photo_gallery)
    click_on "Edit this photo gallery", match: :first

    fill_in "Description", with: @photo_gallery.description
    fill_in "Last updated by", with: @photo_gallery.last_updated_by_id
    fill_in "Title", with: @photo_gallery.title
    click_on "Update Photo gallery"

    assert_text "Photo gallery was successfully updated"
    click_on "Back"
  end

  test "should destroy Photo gallery" do
    visit photo_gallery_url(@photo_gallery)
    click_on "Destroy this photo gallery", match: :first

    assert_text "Photo gallery was successfully destroyed"
  end
end
