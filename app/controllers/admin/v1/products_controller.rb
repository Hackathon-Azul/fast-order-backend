#module Admin::V1

#    class ProductsController < ApiController

 #     def index
  #       @products = load_products
   #   end

    #  private

     # def load_products
      #  permitted = params.permit({ search: :name }, { order: {} }, :page, :length)
       # Admin::ModelLoadingService.new(Product.all, permitted).call
     # end
    #end
 # end
 
 module Admin::V1
  class ProductsController < ApiController
    before_action :load_products, only: [:show, :update, :destroy]
  
    def index
      @loading_service = Admin::ModelLoadingService.new(Product.all, searchable_params)
      @loading_service.call
    end
  
        def create
          @product = Category.new
          @product.attributes = product_params
          save_product!
        end
  
        def show; end
  
        def update
          @product.attributes = product_params
          save_product!
        end
  
        def destroy
          @product.destroy!
        rescue
          render_error(fields: @product.errors.messages)
        end
  
      private
  
      def load_products
        @product = Product.find(params[:id])
      end
  
      def searchable_params
        params.permit({ search: :name }, { order: {} }, :page, :length)
      end
  
      def product_params
        return {} unless params.has_key?(:product)
      params.require(:product).permit(:id, :name)
        end
  
        def save_product!
          @product.save!
          render :show
        rescue
          render_error(fields: @product.errors.messages)
        end
      end
    end