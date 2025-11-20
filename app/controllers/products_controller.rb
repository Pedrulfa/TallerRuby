class ProductsController < ApplicationController
  skip_before_action :authenticate_user!, only: %(index show) # para permitir que cualquiera lo vea

  def index
    @q = Product.ransack(params[:q]) # esto inicia la busqueda
    @products = @q.restult(distinct: true).page(params[:page]).per(12) # aca ejecuto la busqueda, hago que no se repitan y se limita a mostrar 12 nada mas.
  end

  def show
    @product = Product.find(params[:id]) # buscamos por id
    @related_products = Product.where(genre: @product.genre).where.not(id: @product.id).limit(4)
    # busco los relacionados por genero y solo muestro cuatro
  end
end
