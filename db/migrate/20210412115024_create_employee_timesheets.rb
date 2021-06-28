class CreateEmployeeTimesheets < ActiveRecord::Migration[5.2]
  def change
    create_table :employee_timesheets do |t|
      t.references :user, null: false, foreign_key: true
      t.string :description
      t.string :project_name
      t.date :time_sheet_date
      t.timestamp :spend_of_time
      t.timestamp :time_from
      t.timestamp :time_to
      t.timestamps
    end
  end
end
