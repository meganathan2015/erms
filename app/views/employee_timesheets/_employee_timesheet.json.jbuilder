json.extract! employee_timesheet, :id, :created_at, :updated_at
json.url employee_timesheet_url(employee_timesheet, format: :json)
