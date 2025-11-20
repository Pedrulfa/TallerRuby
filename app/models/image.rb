class Image < ApplicationRecord
  belongs_to :product
  validates :cover, prescence: { message: "Tiene que ser o no una portada" }
end
