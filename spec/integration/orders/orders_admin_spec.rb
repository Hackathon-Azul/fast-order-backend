require 'swagger_helper'

describe 'Orders API' do

 path '/admin/v1/orders' do
  
    get 'Get all Orders' do
      tags 'Orders'
      parameter name: :page, in: :query, type: :integer, description: 'Page number. Default: 1', required: false
      parameter name: :length, in: :query, type: :integer, description: 'Per page items.', required: false
      parameter name: :search, in: :query, type: :string, description: 'Search bills by name.', required: false
      parameter name: :order, in: :query, type: :string, description: 'Bills ordenation.', required: false

      produces 'application/json'

      response '200', 'order found' do
        schema type: :object,
        properties: {
          orders: {
            type: :array,
            items: {
              type: :object,
              properties: {
                id: { type: :integer },
                client_name: { type: :string },
                table_id: { type: :integer },
                user_id: { type: :integer },
                status: { type: :string },
                total: { type: :integer }
              }
            }
          },
          meta: {
            type: :object,
            properties: {
              page: { type: :integer},
              length: { type: :integer},
              total: { type: :integer},
              total_pages: { type: :integer}

            }
          }
        }

        let(:id) { Order.create(:order).id }
         run_test!
      end
    end

    path '/admin/v1/orders/{id}' do

     get 'Find a order by id' do
       tags 'Orders'
       produces 'application/json'
       parameter name: :id, :in => :path, :type => :string
 
       response '200', 'order found' do
         schema type: :object,
         properties: {
          order: {
            type: :object,
            properties: {
              client_name: { type: :string },
              table_id: { type: :integer },
              user_id: { type: :integer },
              status: { type: :string },
              total: { type: :integer }
            }
          }
           
        },
        required: [ 'id', 'client_name', 'table_id', 'user_id', 'quantity', 'product_id' ]
 
           let(:id) { Order.create(client_name: "Carla", table_id: 1, user_id: 2,  order_items_attributes: [{ quantity: 3, product_id: 8 }]).id }
           run_test!
       end
 
        response '404', 'order not found' do
          let(:id) { 'invalid' }
          run_test!
        end
      end
    end
  end
end    