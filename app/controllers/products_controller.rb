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
  def new
    @product = Product.new
    @product.build_new_product 
    @product.build_used_product
    # Inicializa un audio vacío opcional para el formulario
    @product.used_product.build_audio
    @product.images.build
  end

  def create
    @product = Product.new(product_params)
    
    # Lógica para limpiar asociaciones vacías según el estado seleccionado
    if params[:state] == 'nuevo'
      @product.used_product = nil 
    else
      @product.new_product = nil
    end

    if @product.save
      # Si se seleccionó una imagen como portada, actualizar cover_image_id
      if params[:cover_image_index].present?
        cover_index = params[:cover_image_index].to_i
        if @product.images[cover_index]
          @product.update(cover_image_id: @product.images[cover_index].id)
        end
      end
      redirect_to products_path, notice: 'Producto creado exitosamente.'
    else
      render :new
    end
  end

  private

  def product_params
    params.require(:product).permit(
      :name, :price, :author, :description, :category, :type, 
      new_product_attributes: [:stock],
      used_product_attributes: [
        :id, 
        audio_attributes: [:id, :url, :_destroy]
      ],
      images_attributes: [:id, :url, :_destroy]
    )
  end
end