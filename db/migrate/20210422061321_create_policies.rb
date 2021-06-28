class CreatePolicies < ActiveRecord::Migration[5.2]
  def change
    create_table :policies do |t|
      t.string :name
      t.string :description
      t.string :attachment

      t.timestamps
    end
  end
end
