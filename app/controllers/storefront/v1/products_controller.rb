module Storefront::V1
  class ProductsController < ApiController
    before_action :load_products, only: [:show]

      def index
        @loading_service = Admin::ModelLoadingService.new(Product.all, search_params)
        @loading_service.call
      end
        
        def show
          @product = Product.find(params[:id])
        end

    private

    def load_products
      @product = Product.find(params[:id])
    end


    def search_params
      params.permit({ search: :name }, { order: {} }, :page, :length)

   end
  end
end