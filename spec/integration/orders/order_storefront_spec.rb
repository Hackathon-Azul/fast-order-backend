require 'swagger_helper'

describe 'Orders API' do

    path '/storefront/v1/orders' do
     
       get 'Get all orders' do
         tags 'Orders'
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
              }
            }
   
            let!(:order) { create(:order) }
            run_test!
           end
         end

        post 'Create new order' do
            tags 'Orders'
     #       parameter name: 'Authorization', in: :header, type: :string, default: 'Bearer c36e6eadde881ca7'
            parameter name: :order, in: :header, schema: {
              type: :object,
              properties: {
                client_name: { type: :string },
                table_id: { type: :integer },
                user_id: { type: :integer },
                order_items_attributes: {
                    type: :array,
                    items: {
                      type: :object,
                      properties: {
                        product_id: { type: :integer },
                        quantity: { type: :integer },
                        comments: { type: :string, 'x-nullable': true }
                      }
                    }
                }
            },
              required: %w[client_name table_id user_id product_id quantity]
            }
      
            response '401', :unauthorized do
              let(:Authorization) { '' }
              let(:order) { { client_name: "Carla", table_id: 1, user_id: 2,  order_items_attributes: [{ quantity: 3, product_id: 8 }] } }
              run_test!
            end
      
            response '201', :created do
              let!(:user) { create(:user) }
            #   let(:Authorization) { 'Bearer ' + user.authentication_token }
              let(:order) { { client_name: "Carla", table_id: 1, user_id: 2,  order_items_attributes: [{ quantity: 3, product_id: 8 }] } }
              run_test!
            end
      
            response '422', :invalid_request do
              let!(:user) { create(:user) }
              let(:Authorization) { 'Bearer ' + user.authentication_token }
              let(:order) { { client_name: "Carla" } }
              run_test!
            end
          end
        end
   
        path '/storefront/v1/orders/{id}' do
   
         get 'Find a order by id' do
           tags 'Orders'
           produces 'application/json'
           parameter name: :id, :in => :path, :type => :string
     
           response '200', 'order found' do
             schema type: :object,
               properties: {
                 id: { type: :integer },
                 client_name: { type: :string },
                 table_id: { type: :integer },
                 user_id: { type: :integer },
                 status: { type: :string },
                 total_value: { type: :integer },
                 order_items_attributes: {
                   type: :array,
                   items: {
                     type: :object,
                     properties: {
                       id: { type: :integer },
                       quantity: { type: :integer },
                       comments: { type: :string, 'x-nullable': true },
                       products: {
                         type: :object,
                         properties: {
                           id: { type: :integer },
                           name: { type: :string },
                           description: { type: :string },
                           price: { type: :integer },
                           avaiable: { type: :boolean },
                           category_id: { type: :integer }
                         }
                       }
   
                     }
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

         put 'Update order by id' do
            tags 'Orders'
            parameter name: :id, :in => :path, :type => :string
            parameter name: :order, in: :header, schema: {
              type: :object,
              properties: {
                id: { type: :integer },
                client_name: { type: :string },
                table_id: { type: :integer },
                user_id: { type: :integer },
                status: { type: :string },
                total_value: { type: :integer },
                order_items_attributes: {
                  type: :array,
                  items: {
                    type: :object,
                    properties: {
                      id: { type: :integer },
                      quantity: { type: :integer },
                      comments: { type: :string, 'x-nullable': true },
                      products: {
                        type: :object,
                        properties: {
                          id: { type: :integer },
                          name: { type: :string },
                          description: { type: :string },
                          price: { type: :integer },
                          avaiable: { type: :boolean },
                          category_id: { type: :integer }
                        }
                      }
  
                    }
                  }
                }
              },
            required: ['id']
        }
            response '200', :success do
              let!(:user) { create(:user) }
              let!(:id) { create(:order, user: user).id }
              let(:Authorization) { 'Bearer ' + user.authentication_token }
              let(:order) { { client_name: "Carla", table_id: 1, user_id: 2,  order_items_attributes: [{ quantity: 3, product_id: 8 }] } }
              run_test!
            end
      
            response '404', :not_found do
              let!(:user) { create(:user) }
              let(:Authorization) { 'Bearer ' + user.authentication_token }
              let(:order) { { client_name: 'Title', table_id: 1 } }
              let!(:id) { 'invalid' }
              run_test!
            end
          end
        end
      end            