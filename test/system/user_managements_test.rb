require "application_system_test_case"

class UserManagementsTest < ApplicationSystemTestCase
  setup do
    @user_management = user_managements(:one)
  end

  test "visiting the index" do
    visit user_managements_url
    assert_selector "h1", text: "User Managements"
  end

  test "creating a User management" do
    visit user_managements_url
    click_on "New User Management"

    click_on "Create User management"

    assert_text "User management was successfully created"
    click_on "Back"
  end

  test "updating a User management" do
    visit user_managements_url
    click_on "Edit", match: :first

    click_on "Update User management"

    assert_text "User management was successfully updated"
    click_on "Back"
  end

  test "destroying a User management" do
    visit user_managements_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "User management was successfully destroyed"
  end
end
