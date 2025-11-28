module Backstore
  class SalesController < ApplicationController
  before_action :require_login

  def index
    if params[:q] && params[:q][:created_at_lteq].present?
      params[:q][:created_at_lteq] = "#{params[:q][:created_at_lteq]} 23:59:59"
    end
    @q = Sale.ransack(params[:q])
    @sales = @q.result(distinct: true).includes(:user, :client).order(created_at: :desc).page(params[:page]).per(10)
  end

  def show
    @sale = Sale.find(params[:id])
  end

  def new
    @sale = Sale.new
    @sale.sale_products.build
  end

  def create
    @sale = Sale.create_with_stock_control(sale_params.merge(user: current_user))

    if @sale.persisted?
      redirect_to [:backstore, @sale], notice: 'Venta creada exitosamente.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @sale = Sale.find(params[:id])
    @sale.cancel!
    redirect_to backstore_sales_path, notice: 'Venta cancelada exitosamente.'
  end

  def invoice
    @sale = Sale.find(params[:id])
    pdf = InvoicePdf.new(@sale)
    send_data pdf.render, filename: "factura_#{@sale.id}.pdf", type: "application/pdf", disposition: "inline"
  end

  private

  def sale_params
    params.require(:sale).permit(:total, client_attributes: [:dni, :name, :surname], sale_products_attributes: [:product_id, :quantity, :_destroy])
  end
end
end
