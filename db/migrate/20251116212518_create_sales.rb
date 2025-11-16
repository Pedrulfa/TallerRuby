class CreateSales < ActiveRecord::Migration[8.1]
  def change
    create_table :sales do |t|
      t.datetime :date
      t.decimal :total

      t.timestamps
    end
  end
end
