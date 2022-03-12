require 'swagger_helper'

describe 'Products API' do

    path '/storefront/v1/products' do
     
       get 'Get all products' do
         tags 'Products'
         produces 'application/json'
   
         response '200', 'product found' do
           schema type: :object,
           properties: {
           products: {
                type: :array,
                items: {
                  type: :object,
                  properties: {
                      id: { type: :integer },
                      name: { type: :string },
                      description: { type: :string },
                      price: { type: :integer },
                      category: { 
                          type: :object,
                          properties: {
                            id: { type: :integer },
                            title: { type: :string },
                            created_at: { type: :string, format: :datetime },
                            updated_at: { type: :string, format: :datetime }
                          }
                       }
                  }
                }
              }
            }
   
            let!(:order) { create(:order) }
            run_test!
           end
         end

         path '/storefront/v1/products/{id}' do
   
            get 'Find a product by id' do
              tags 'Products'
              produces 'application/json'
              parameter name: :id, :in => :path, :type => :string
        
              response '200', 'product found' do
                schema type: :object,
                  properties: {
                    id: { type: :integer },
                    name: { type: :string },
                    description: { type: :string },
                    price: { type: :integer },
                    category: { 
                        type: :object,
                        properties: {
                          id: { type: :integer },
                          title: { type: :string },
                          created_at: { type: :string, format: :datetime },
                          updated_at: { type: :string, format: :datetime }
                        }
                     }
                  },
                  required: [ 'id' ]
        
                let(:id) { Product.create(name: 'Misto quente', avaiable: true, description: 'Pão de forma, mussarela, presunto, alface e maionese', price: 10.50, category_id: 1).id }
                run_test!
              end
        
              response '404', 'product not found' do
                let(:id) { 'invalid' }
                run_test!
              end
            end
       end
    end
end