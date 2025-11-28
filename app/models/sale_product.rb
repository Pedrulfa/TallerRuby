class SaleProduct < ApplicationRecord
  belongs_to :sale
  belongs_to :product

  validates :quantity, presence: { message: "no puede estar en blanco" },
                       numericality: { greater_than: 0, only_integer: true, message: "debe ser un número mayor a 0" }

  validate :stock_availability

  private

  def stock_availability
    return unless product && quantity

    if quantity > product.current_stock
      errors.add(:quantity, "supera el stock disponible (#{product.current_stock})")
    end
  end
end
