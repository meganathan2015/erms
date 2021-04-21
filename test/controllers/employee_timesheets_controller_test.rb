require 'test_helper'

class EmployeeTimesheetsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @employee_timesheet = employee_timesheets(:one)
  end

  test "should get index" do
    get employee_timesheets_url
    assert_response :success
  end

  test "should get new" do
    get new_employee_timesheet_url
    assert_response :success
  end

  test "should create employee_timesheet" do
    assert_difference('EmployeeTimesheet.count') do
      post employee_timesheets_url, params: { employee_timesheet: {  } }
    end

    assert_redirected_to employee_timesheet_url(EmployeeTimesheet.last)
  end

  test "should show employee_timesheet" do
    get employee_timesheet_url(@employee_timesheet)
    assert_response :success
  end

  test "should get edit" do
    get edit_employee_timesheet_url(@employee_timesheet)
    assert_response :success
  end

  test "should update employee_timesheet" do
    patch employee_timesheet_url(@employee_timesheet), params: { employee_timesheet: {  } }
    assert_redirected_to employee_timesheet_url(@employee_timesheet)
  end

  test "should destroy employee_timesheet" do
    assert_difference('EmployeeTimesheet.count', -1) do
      delete employee_timesheet_url(@employee_timesheet)
    end

    assert_redirected_to employee_timesheets_url
  end
end
