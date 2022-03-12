module Storefront::V1
  class OrdersController < ApiController
  before_action :set_order, only: [:show, :update]

  def index
    @orders = Order.all.order(:id).reverse_order
  end

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

  def update
    @order.attributes = order_params
    save_order!
  end

  private

  def set_order
    @order = Order.find(params[:id])
  end

  def save_order!
    @order.save!
    render :show
  rescue
    render_error(fields: @order.errors.messages)
  end

  def order_params
    params.require(:order).permit(
      :id, :client_name, :table_id, :user_id, :status, :total, 
       order_items_attributes: [:quantity, :product_id, :comments]
    )
  end

end
end