require "test_helper"

class CommentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @micropost = microposts(:one)
    @comment = comments(:one)
  end

  test "should get index" do
    get micropost_comments_url(micropost_id: @micropost.id)
    assert_response :success
  end

  # test "should get new" do
  #   get new_comment_url
  #   assert_response :success
  # end

  test "should create comment" do
    assert_difference("Comment.count") do
      post "/post/#{@micropost.id}/comments", params: { comment: { body: @comment.body, user_id: @comment.user_id, micropost_id: @micropost.id } }
    end

    assert_redirected_to micropost_url(@micropost.id)
  end

  # test "should show comment" do
  #   get comment_url(@comment)
  #   assert_response :success
  # end

  # test "should get edit" do
  #   get edit_comment_url(@comment)
  #   assert_response :success
  # end

  # test "should update comment" do
  #   patch comment_url(@comment), params: { comment: { body: @comment.body, user_id: @comment.user_id } }
  #   assert_redirected_to comment_url(@comment)
  # end

  test "should delete comment" do
    assert_difference("Comment.count", -1) do
      delete "/post/#{@micropost.id}/comments/#{@comment.id}"
    end

    assert_redirected_to micropost_url(@micropost.id)
  end
end
