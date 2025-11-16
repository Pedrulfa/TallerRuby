class CreateProducts < ActiveRecord::Migration[8.1]
  def change
    create_table :products do |t|
      t.string :name
      t.string :description
      t.string :author
      t.decimal :price
      t.string :category
      t.string :type
      t.datetime :upload_date
      t.datetime :last_modification
      t.datetime :date_removed

      t.timestamps
    end
  end
end
