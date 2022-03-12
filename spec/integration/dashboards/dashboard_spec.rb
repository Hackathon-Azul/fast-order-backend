require 'swagger_helper'

describe 'Dashboard API' do

    path '/admin/v1/dashboard/sales_ranges_for_user' do
     
       get 'Get sales range by month or day for user' do
         tags 'Dashboard'
         parameter name: :min_date, in: :query, type: :string, format: :date, description: 'Mininum sales range. Default: month', required: false
         parameter name: :max_date, in: :query, type: :string, format: :date, description: 'Maximum sales range. Default: month', required: false
         parameter name: :user_id, in: :query, type: :integer, description: 'User id. Default: 1', required: false
         produces 'application/json'
   
         response '200', 'sales for user found' do
           schema type: :object,
           properties: {
            sales_ranges: {
                type: :array,
                items: {
                  type: :object,
                  properties: {
                    date: { type: :string, format: :date },
                    total_sold: { type: :integer, format: :float },
                    amount_of_sales: { type: :integer, format: :float }                                           
                  }
                }
              }
            }
   
            let!(:dashboard) { create(:dashboard) }
            run_test!
           end
         end

         path '/admin/v1/dashboard/sales_ranges' do
     
          get 'Get sales range by month or day' do
            tags 'Dashboard'
            parameter name: :min_date, in: :query, type: :string, format: :date, description: 'Mininum sales range. Default: month', required: false
            parameter name: :max_date, in: :query, type: :string, format: :date, description: 'Maximum sales range. Default: month', required: false
            produces 'application/json'
      
            response '200', 'sales found' do
              schema type: :object,
              properties: {
               sales_ranges: {
                   type: :array,
                   items: {
                     type: :object,
                     properties: {
                       date: { type: :string, format: :date },
                       total_sold: { type: :integer, format: :float }                      
                     }
                   }
                 }
               }
      
            let!(:dashboard) { create(:dashboard) }
            run_test!
           end
         end

         path '/admin/v1/dashboard/summaries' do
     
          get 'Get production summary' do
            tags 'Dashboard'
            parameter name: :min_date, in: :query, type: :string, format: :date, description: 'Mininum summary range. Default: month', required: false
            parameter name: :max_date, in: :query, type: :string, format: :date, description: 'Maximum summary range. Default: month', required: false
            produces 'application/json'
      
            response '200', 'summary found' do
              schema type: :object,
              properties: {
                summary: {
                   type: :array,
                   items: {
                     type: :object,
                     properties: {
                      users: { type: :integer },
                      products: { type: :integer },
                      orders: { type: :integer },
                      profit: { type: :integer }
                     }
                   }
                 }
               }
      
            let!(:dashboard) { create(:dashboard) }
            run_test!
           end
         end

         path '/admin/v1/dashboard/top_five_products' do
     
          get 'Get top 5 products' do
            tags 'Dashboard'
            parameter name: :min_date, in: :query, type: :string, format: :date, description: 'Mininum products range. Default: month', required: false
            parameter name: :max_date, in: :query, type: :string, format: :date, description: 'Maximum products range. Default: month', required: false
            produces 'application/json'
      
            response '200', 'top 5 found' do
              schema type: :object,
              properties: {
                top_five_products: {
                   type: :array,
                   items: {
                     type: :object,
                     properties: {
                      product: { type: :string },
                      quantity: { type: :integer },
                      total_sold: { type: :integer }
                     }
                   }
                 }
               }
      
            let!(:dashboard) { create(:dashboard) }
            run_test!
           end
         end
       end
     end
    end
  end
end