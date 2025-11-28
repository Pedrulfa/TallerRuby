class CreateSales < ActiveRecord::Migration[8.1]
  def change
    create_table :sales do |t|
      t.datetime :date
      t.decimal :total
      t.boolean :completed, default: true     # Si la venta se cancela se pone en false

      t.timestamps
    end
  end
end
