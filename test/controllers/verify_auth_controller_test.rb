require 'test_helper'

class VerifyAuthControllerTest < ActionDispatch::IntegrationTest
  test "should get request" do
    get verify_auth_request_url
    assert_response :success
  end

  test "should get response" do
    get verify_auth_response_url
    assert_response :success
  end

end
