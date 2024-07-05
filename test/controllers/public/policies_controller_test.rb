require "test_helper"

class Public::PoliciesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get public_policies_index_url
    assert_response :success
  end
end
