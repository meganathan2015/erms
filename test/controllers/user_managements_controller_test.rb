require 'test_helper'

class UserManagementsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user_management = user_managements(:one)
  end

  test "should get index" do
    get user_managements_url
    assert_response :success
  end

  test "should get new" do
    get new_user_management_url
    assert_response :success
  end

  test "should create user_management" do
    assert_difference('UserManagement.count') do
      post user_managements_url, params: { user_management: {  } }
    end

    assert_redirected_to user_management_url(UserManagement.last)
  end

  test "should show user_management" do
    get user_management_url(@user_management)
    assert_response :success
  end

  test "should get edit" do
    get edit_user_management_url(@user_management)
    assert_response :success
  end

  test "should update user_management" do
    patch user_management_url(@user_management), params: { user_management: {  } }
    assert_redirected_to user_management_url(@user_management)
  end

  test "should destroy user_management" do
    assert_difference('UserManagement.count', -1) do
      delete user_management_url(@user_management)
    end

    assert_redirected_to user_managements_url
  end
end
