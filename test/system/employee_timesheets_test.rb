require "application_system_test_case"

class EmployeeTimesheetsTest < ApplicationSystemTestCase
  setup do
    @employee_timesheet = employee_timesheets(:one)
  end

  test "visiting the index" do
    visit employee_timesheets_url
    assert_selector "h1", text: "Employee Timesheets"
  end

  test "creating a Employee timesheet" do
    visit employee_timesheets_url
    click_on "New Employee Timesheet"

    click_on "Create Employee timesheet"

    assert_text "Employee timesheet was successfully created"
    click_on "Back"
  end

  test "updating a Employee timesheet" do
    visit employee_timesheets_url
    click_on "Edit", match: :first

    click_on "Update Employee timesheet"

    assert_text "Employee timesheet was successfully updated"
    click_on "Back"
  end

  test "destroying a Employee timesheet" do
    visit employee_timesheets_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Employee timesheet was successfully destroyed"
  end
end
