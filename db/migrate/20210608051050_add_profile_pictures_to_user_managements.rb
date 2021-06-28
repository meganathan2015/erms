class AddProfilePicturesToUserManagements < ActiveRecord::Migration[5.2]
  def change
    add_column :user_managements, :profile_pictures, :string
  end
end
