require 'swagger_helper'

describe 'Tables API' do

    path '/storefront/v1/tables' do
     
       get 'Get all tables' do
         tags 'Tables'
         produces 'application/json'
   
         response '200', 'tables found' do
           schema type: :object,
           properties: {
            tables: {
                type: :array,
                items: {
                  type: :object,
                  properties: {
                      id: { type: :integer },
                      table_number: { type: :string },
                      avaliable_table: { type: :boolean },
                      
                  }
                }
              }
            }
   
            let!(:table) { create(:table) }
            run_test!
           end
         end
       end
     end