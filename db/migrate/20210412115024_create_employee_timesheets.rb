class CreateEmployeeTimesheets < ActiveRecord::Migration[5.2]
  def change
    create_table :employee_timesheets do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title
      t.string :description
      t.string :project_name
      t.date :time_sheet_date
      t.decimal :spend_of_time, precision: 10, scale: 2
      t.timestamp :time_from
      t.timestamp :time_to
      t.timestamp :break_from
      t.timestamp :break_to
      t.timestamp :total_break_time
      t.timestamp :office_total_hours
      t.integer :status, default: 0
      t.timestamps
    end
  end
end
