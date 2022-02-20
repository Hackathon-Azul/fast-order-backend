module Admin::V1
    class BillsController < ApiController
      before_action :load_bills, only: [:show, :update, :destroy]
    
      def index
        @loading_service = Admin::ModelLoadingService.new(Bill.all, searchable_params)
        @loading_service.call
      end
    
          def create
            @bill = Bill.new
            @bill.attributes = bill_params
            save_bill!
          end
    
          def show; end
    
          def update
            @bill.attributes = bill_params
            save_bill!
          end
    
          def destroy
            @bill.destroy!
          rescue
            render_error(fields: @bill.errors.messages)
          end
    
        private
    
        def load_bills
          @bill = Bill.find(params[:id])
        end
    
        def searchable_params
          params.permit({ search: :name }, { order: {} }, :page, :length)
        end
    
        def bill_params
          return {} unless params.has_key?(:bill)
        params.require(:bill).permit(:id, :total)
          end
    
          def save_bill!
            @bill.save!
            render :show
          rescue
            render_error(fields: @bill.errors.messages)
          end
        end
      end