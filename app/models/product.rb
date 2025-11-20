class Product < ApplicationRecord
  has_many :images, dependent: :destroy # tiene muchas imagenes, y si se el producto borra, borra tambien las imagenes
  has_one :audio, dependent: :destroy # tiene un solo audio y se borra como el de arriba

  validates :name, :price, :stock, presence: true # valida el nombre precio y stock, el presence no permite guardarlo si le falta alguno de esos

  def cover_image
    images.find_by(cover: true) || images.first # si tiene portada la pone como portada, sino usa la que tiene.
  end
end
