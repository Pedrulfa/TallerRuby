class ProductsController < ApplicationController
  def index
    @q = Product.ransack(params[:q])
    @products = @q.result(distinct: true).page(params[:page]).per(12)
  end

  def show
    @product = Product.find(params[:id])
    @related_products = Product.where(category: @product.category)
                               .where.not(id: @product.id)
                               .limit(4)
  end
end