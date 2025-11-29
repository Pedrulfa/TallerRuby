require "prawn"
require "prawn/table"

class InvoicePdf < Prawn::Document
  def initialize(sale)
    super()
    @sale = sale
    header
    client_details
    items_table
    total_price
  end

  def header
    text "Factura de Venta", size: 30, style: :bold
    text "Venta ##{@sale.id}", size: 18
    text "Fecha: #{@sale.created_at.strftime("%d/%m/%Y %H:%M")}", size: 12
    move_down 20
  end

  def client_details
    text "Datos del Cliente", size: 14, style: :bold
    if @sale.client
      text "Nombre: #{@sale.client.name} #{@sale.client.surname}"
      text "DNI: #{@sale.client.dni}"
    else
      text "Consumidor Final"
    end
    move_down 10
    text "Vendedor: #{@sale.user.name} #{@sale.user.surname}"
    move_down 20
  end

  def items_table
    table item_rows do
      row(0).font_style = :bold
      columns(1..3).align = :right
      self.row_colors = [ "DDDDDD", "FFFFFF" ]
      self.header = true
      self.width = 540
    end
  end

  def item_rows
    [ [ "Producto", "Cantidad", "Precio Unitario", "Subtotal" ] ] +
    @sale.sale_products.map do |item|
      [ item.product.name, item.quantity, price(item.price), price(item.price * item.quantity) ]
    end
  end

  def total_price
    move_down 15
    text "Total: #{price(@sale.total)}", size: 16, style: :bold, align: :right
  end

  def price(num)
    ActionController::Base.helpers.number_to_currency(num)
  end
end
