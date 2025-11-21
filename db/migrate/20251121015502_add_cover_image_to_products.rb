class AddCoverImageToProducts < ActiveRecord::Migration[8.1]
  def change
    add_column :products, :cover_image_id, :integer
    add_index :products, :cover_image_id
    add_foreign_key :products, :images, column: :cover_image_id
  end
end
