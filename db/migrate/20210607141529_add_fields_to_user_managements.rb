class AddFieldsToUserManagements < ActiveRecord::Migration[5.2]
  def change
    add_column :user_managements, :emp_code, :string
    add_column :user_managements, :mother_name, :string
    add_column :user_managements, :gender, :string
    add_column :user_managements, :phone, :string
    add_column :user_managements, :pan_details, :string
    add_column :user_managements, :aadhar_details, :string
    add_column :user_managements, :address, :string
  end
end
