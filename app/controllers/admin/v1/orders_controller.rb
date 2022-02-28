module Admin::V1
  class OrdersController < ApiController
    before_action :load_order, only: :show

    def index
      @loading_service = Admin::ModelLoadingService.new(Order.all, searchable_params)
      @loading_service.call
    end

    def show
    end

    private

    def load_order
      @order = Order.find(params[:id])
    end

    def searchable_params
      params.permit({ order: {} }, :page, :length)
    end
  end
end