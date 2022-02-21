module Storefront::V1
  class OrdersController < ApiController
  before_action :set_order, only: :show

  def create
    @order = Order.new(order_params)
    if @order.save
      @order
    else
      render json: @order.errors, status: :unprocessable_entity
    end
  end

  def show
  end

  private

  def set_order
    @order = Order.find(params[:id])
  end

  def order_params
    params.require(:order).permit(
      :id, :client_name, :table_id, :user_id, :status, :total, 
       order_items_attributes: [:quantity, :product_id, :comments]
    )
  end
end
end