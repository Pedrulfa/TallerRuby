class Product < ApplicationRecord
  has_many :images, dependent: :destroy
  self.inheritance_column = nil

  has_one :new_product, dependent: :destroy
  has_one :used_product, dependent: :destroy

  validates :name, :price, :author, presence: true

  accepts_nested_attributes_for :new_product
  accepts_nested_attributes_for :used_product

  ransacker :name_sin_acentos do
    Arel.sql("REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(LOWER(name), 'á', 'a'), 'é', 'e'), 'í', 'i'), 'ó', 'o'), 'ú', 'u')")
  end

  ransacker :author_sin_acentos do
    Arel.sql("REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(LOWER(author), 'á', 'a'), 'é', 'e'), 'í', 'i'), 'ó', 'o'), 'ú', 'u')")
  end

  def self.ransackable_attributes(auth_object = nil)
    [ "author", "category", "description", "id", "name", "price", "type", "created_at", "name_sin_acentos", "author_sin_acentos" ]
  end

  def cover_image
    images.first
  end

  def current_stock
    new_product&.stock || 1
  end
end
