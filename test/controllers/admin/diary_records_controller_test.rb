require "test_helper"

class Admin::DiaryRecordsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_diary_records_index_url
    assert_response :success
  end

  test "should get destroy" do
    get admin_diary_records_destroy_url
    assert_response :success
  end
end
