class Audio < ApplicationRecord
  belongs_to :used_product
  has_one_attached :file
end
