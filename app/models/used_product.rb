class UsedProduct < ApplicationRecord
  belongs_to :product
  has_one :audio, dependent: :destroy

  accepts_nested_attributes_for :audio, allow_destroy: true, reject_if: :all_blank
end
