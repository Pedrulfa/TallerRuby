class Sale < ApplicationRecord
  belongs_to :user
  belongs_to :client
  has_many :sale_products, dependent: :destroy

  accepts_nested_attributes_for :sale_products, allow_destroy: true, reject_if: :all_blank
  validates :total, presence: true

  def client_attributes=(attributes)
    dni = attributes[:dni]
    if dni.present?
      self.client = Client.find_or_initialize_by(dni: dni)
    else
      self.client ||= Client.new
    end
    self.client.assign_attributes(attributes)
  end
  # ------------------
  def self.create_with_stock_control(params)
    sale = new(params)

    transaction do
      if sale.client.nil?
        sale.errors.add(:base, "Debe ingresar los datos del cliente")
        raise ActiveRecord::Rollback
      elsif !sale.client.valid?
        sale.client.errors.full_messages.each do |msg|
          sale.errors.add(:base, "Cliente: #{msg}")
        end
        raise ActiveRecord::Rollback
      end

      # 1. Calcular total y asignar precios (sin tocar stock aún)
      total_amount = 0
      sale.sale_products.each do |item|
        product = item.product
        if product
          item.price = product.price
          total_amount += item.price * (item.quantity || 0)
        end
      end
      sale.total = total_amount

      # 2. Validar todo (Cliente, Venta, Productos)
      if !sale.valid?
        raise ActiveRecord::Rollback
      end

      # 3. Si es válido, descontar stock y guardar
      sale.sale_products.each do |item|
        item.product.decrement_stock!(item.quantity)
      end

      sale.save!
    end

    sale
  rescue ActiveRecord::RecordInvalid => e
    sale.errors.add(:base, e.message)
    sale
  end
  def cancel!
    return if cancelled_at.present?

    transaction do
      sale_products.each do |item|
        item.product.increment_stock!(item.quantity)
      end
      update!(cancelled_at: Time.current)
    end
  end
  def self.ransackable_attributes(auth_object = nil)
    [ "created_at", "cancelled_at", "total", "id" ]
  end

  def self.ransackable_associations(auth_object = nil)
    [ "user", "client" ]
  end
end
