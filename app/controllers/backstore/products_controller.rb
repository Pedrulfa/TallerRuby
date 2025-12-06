module Backstore
    class ProductsController < ApplicationController
        before_action :require_login
        def index
            @q = Product.ransack(params[:q])

            # Filtrar por estado (activos o eliminados)
            scope = params[:scope] == 'inactive' ? Product.where.not(date_removed: nil) : Product.where(date_removed: nil)

            @products = @q.result(distinct: true)
                        .merge(scope)
                        .includes(:images, :new_product, :used_product)
                        .order(created_at: :desc)
                        .page(params[:page]).per(20)
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
                redirect_to backstore_products_path, notice: 'Producto creado exitosamente.'
            else
                    render :new
            end
            end

        def edit
            @product = Product.find(params[:id])
            
            # Asegurar que existan las asociaciones para el formulario
            @product.build_new_product unless @product.new_product
            @product.build_used_product unless @product.used_product
            @product.used_product.build_audio unless @product.used_product.audio
            @product.images.build if @product.images.empty?
        end        
        def update
            @product = Product.find(params[:id])
            
            if params[:state] == 'nuevo'
                @product.used_product&.destroy
                @product.build_new_product unless @product.new_product
            else
                @product.new_product&.destroy
                @product.build_used_product unless @product.used_product
            end
            
            if @product.update(product_params)
                # Si se seleccionó una imagen como portada, actualizar cover_image_id
                if params[:cover_image_index].present?
                    cover_index = params[:cover_image_index].to_i
                    selected_image = @product.images.find { |img| img.id.present? }
                    if @product.images[cover_index]
                        @product.update(cover_image_id: @product.images[cover_index].id)
                    end
                end
                redirect_to backstore_products_path, notice: "Producto actualizado."
            else
                render :edit
            end
        end        
        def destroy
            @product = Product.find(params[:id])

            # setear fecha de baja
            @product.update(date_removed: Time.current)

            # Si es producto nuevo, poner stock en 0
            if @product.new_product
            @product.new_product.update(stock: 0)
            end

            redirect_to backstore_products_path, notice: "Producto dado de baja exitosamente."
        end
        private

        def product_params
            params.require(:product).permit(
                :name, :price, :author, :description, :category, :type,
                new_product_attributes: [ :id, :stock ],
                used_product_attributes: [
                :id,
                audio_attributes: [ :id, :file, :_destroy ]
                ],
                images_attributes: [ :id, :file, :_destroy ]
            )
        end
    end
end
