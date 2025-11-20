class CreatePermissions < ActiveRecord::Migration[8.1]
  def change
    create_table :permissions do |t|
      t.string :name, null: false
      t.timestamps
    end
  end
end
