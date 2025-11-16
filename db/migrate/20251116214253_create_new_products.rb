class CreateNewProducts < ActiveRecord::Migration[8.1]
  def change
    create_table :new_products do |t|
      t.references :product, null: false, foreign_key: true
      t.integer :stock

      t.timestamps
    end
  end
end
