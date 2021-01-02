require 'test_helper'

class CommentsControllerTest < ActionDispatch::IntegrationTest
  test "should get creat" do
    get comments_creat_url
    assert_response :success
  end

  test "should get destroy" do
    get comments_destroy_url
    assert_response :success
  end

end
