module Admin::V1
    class TablesController < ApiController
      before_action :load_tables, only: [:show, :update, :destroy]
    
      def index
        @loading_service = Admin::ModelLoadingService.new(Table.all, searchable_params)
        @loading_service.call
      end
    
          def create
            @table = Table.new
            @table.attributes = table_params
            save_table!
          end
    
          def show; end
    
          def update
            @table.attributes = table_params
            save_table!
          end
    
          def destroy
            @table.destroy!
          rescue
            render_error(fields: @table.errors.messages)
          end
    
        private
    
        def load_tables
          @table = Table.find(params[:id])
        end
    
        def searchable_params
          params.permit({ search: :table_number }, { order: {} }, :page, :length)
        end
    
        def table_params
          return {} unless params.has_key?(:table)
        params.require(:table).permit(:id, :table_number, :avaliable_table)
          end
    
          def save_table!
            @table.save!
            render :show
          rescue
            render_error(fields: @table.errors.messages)
          end
        end
      end