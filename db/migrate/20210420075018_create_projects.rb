class CreateProjects < ActiveRecord::Migration[5.2]
  def change
    create_table :projects do |t|
      t.string :project_name
      t.string :reporting_manager
      t.integer :status
      t.timestamps
    end
  end
end
