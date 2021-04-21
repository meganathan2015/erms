class CreateAttendances < ActiveRecord::Migration[5.2]
  def change
    create_table :attendances do |t|
      t.references :user, null: false, foreign_key: true
      t.date :start_date
      t.date :end_date
      t.integer :no_of_days
      t.text :reason_for_leave
      t.integer :manager_id
      t.string :status
      t.text :reason_for_rejection

      t.timestamps
    end
  end
end
