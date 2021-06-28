class AddDobDojToUserManagements < ActiveRecord::Migration[5.2]
  def change
    add_column :user_managements, :bg_group, :string
    add_column :user_managements, :dob, :date
    add_column :user_managements, :doj, :date
    add_column :user_managements, :status, :string
  end
end
