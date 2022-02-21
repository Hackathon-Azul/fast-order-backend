module Admin::V1
    class OrderItemsController < ApiController
      before_action :load_order_items, only: [:show, :update, :destroy]
    
      def index
        @loading_service = Admin::ModelLoadingService.new(OrderItem.all, searchable_params)
        @loading_service.call
      end
    
          def create
            @order_item = OrderItem.new
            @order_item.attributes = order_item_params
            save_order_item!
          end
    
          def show; end
    
          def update
            @order_item.attributes = order_item_params
            save_order_item!
          end
    
          def destroy
            @order_item.destroy!
          rescue
            render_error(fields: @order_item.errors.messages)
          end
    
        private
    
        def load_order_items
          @order_item = OrderItem.find(params[:id])
        end
    
        def searchable_params
          params.permit({ search: :name }, { order: {} }, :page, :length)
        end
    
        def order_item_params
          return {} unless params.has_key?(:order_item)
        params.require(:order_item).permit(:id, :product_id, :quantity, :comments, :order_id)
          end
    
          def save_order_item!
            @order_item.save!
            render :show
          rescue
            render_error(fields: @order_item.errors.messages)
          end
        end
      end