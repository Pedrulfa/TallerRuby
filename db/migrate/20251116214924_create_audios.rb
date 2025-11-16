class CreateAudios < ActiveRecord::Migration[8.1]
  def change
    create_table :audios do |t|
      t.references :used_product, null: false, foreign_key: true
      t.string :url

      t.timestamps
    end
  end
end
