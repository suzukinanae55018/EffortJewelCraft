require "test_helper"

class Public::DiaryRecordsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get public_diary_records_new_url
    assert_response :success
  end

  test "should get create" do
    get public_diary_records_create_url
    assert_response :success
  end

  test "should get index" do
    get public_diary_records_index_url
    assert_response :success
  end

  test "should get show" do
    get public_diary_records_show_url
    assert_response :success
  end

  test "should get edit" do
    get public_diary_records_edit_url
    assert_response :success
  end

  test "should get update" do
    get public_diary_records_update_url
    assert_response :success
  end

  test "should get destroy" do
    get public_diary_records_destroy_url
    assert_response :success
  end
end
