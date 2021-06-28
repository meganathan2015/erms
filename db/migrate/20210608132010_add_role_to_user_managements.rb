class AddRoleToUserManagements < ActiveRecord::Migration[5.2]
  def change
    add_column :user_managements, :role, :integer
  end
end
