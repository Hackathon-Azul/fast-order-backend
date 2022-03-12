require 'swagger_helper'

describe 'Products API' do

 path '/admin/v1/products' do
  
    get 'Get all Products' do
      tags 'Products'
      parameter name: :page, in: :query, type: :integer, description: 'Page number. Default: 1', required: false
      parameter name: :length, in: :query, type: :integer, description: 'Per page items.', required: false
      parameter name: :search, in: :query, type: :string, description: 'Search bills by name.', required: false
      parameter name: :order, in: :query, type: :string, description: 'Bills ordenation.', required: false

      produces 'application/json'

      response '200', 'bills found' do
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
                avaiable: { type: :boolean },
                category_id: { type: :integer }

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

        let(:id) { User.create(:product).id }
         run_test!
      end
    end

    post 'Create new product' do
        tags 'Products'
 #       parameter name: 'Authorization', in: :header, type: :string, default: 'Bearer c36e6eadde881ca7'
        parameter name: :product, in: :header, schema: {
          type: :object,
          properties: {
            name: { type: :string },
            description: { type: :string },
            price: { type: :integer },
            avaiable: { type: :boolean },
            category_id: { type: :integer }
          },
          required: %w[name description price avaiable category_id]
        }
  
        response '401', :unauthorized do
          let(:Authorization) { '' }
          let(:product) { { name: '122' } }
          run_test!
        end
  
        response '201', :created do
          let!(:user) { create(:user) }
        #   let(:Authorization) { 'Bearer ' + user.authentication_token }
          let(:product) { { name: 'Misto quente', avaiable: true, description: 'Pão de forma, mussarela, presunto, alface e maionese', price: 10.50, category_id: 1 } }
          run_test!
        end
  
        response '422', :invalid_request do
          let!(:user) { create(:user) }
          let(:Authorization) { 'Bearer ' + user.authentication_token }
          let(:product) { { id: 1 } }
          run_test!
        end
      end
    end

    path '/admin/v1/products/{id}' do

     get 'Find a product by id' do
       tags 'Products'
       produces 'application/json'
       parameter name: :id, :in => :path, :type => :string
 
       response '200', 'product found' do
         schema type: :object,
         properties: {
          product: {
            type: :object,
            properties: {
              id: { type: :integer },
              name: { type: :string }
            }
          }
           
        },
           required: [ 'id', 'name' ]
 
         let(:id) { Product.create(name: 'Misto quente', avaiable: true, description: 'Pão de forma, mussarela, presunto, alface e maionese', price: 10.50, category_id: 1).id }
         run_test!
       end
 
       response '404', 'product not found' do
         let(:id) { 'invalid' }
         run_test!
       end
     end

     put 'Update product by id' do
        tags 'Products'
        parameter name: :id, :in => :path, :type => :string
        parameter name: :product, in: :header, schema: {
          type: :object,
          properties: {
            name: { type: :string },
            description: { type: :string },
            price: { type: :integer },
            avaiable: { type: :boolean },
            category_id: { type: :integer }
        },
        required: %w[name description price avaiable category_id]
      }
        response '200', :success do
          let!(:user) { create(:user) }
          let!(:id) { create(:product, user: user).id }
          let(:Authorization) { 'Bearer ' + user.authentication_token }
          let(:product) {{ name: 'Misto quente', avaiable: true, description: 'Pão de forma, mussarela, presunto, alface e maionese', price: 10.50, category_id: 1 }} 
          run_test!
        end
  
        response '404', :not_found do
          let!(:user) { create(:user) }
          let(:Authorization) { 'Bearer ' + user.authentication_token }
          let(:product) {{ name: 'Misto quente', avaiable: true, description: 'Pão de forma, mussarela, presunto, alface e maionese', price: 10.50, category_id: 1 }} 
          let!(:id) { 'invalid' }
          run_test!
        end
      end

      delete 'Delete product by id' do
        tags 'Products'
        parameter name: :id, in: :path, type: :integer
        parameter name: 'Authorization', in: :header, type: :string, default: 'Bearer c36e6eadde881ca7'
        response '204', :no_content do
          let!(:user) { create(:user) }
          let(:Authorization) { 'Bearer ' + user.authentication_token }
          let!(:id) { create(:product, user: user).id }
          run_test!
        end
  
        response '404', :not_found do
          let!(:user) { create(:user) }
          let(:Authorization) { 'Bearer ' + user.authentication_token }
          let!(:id) { 'invalid' }
          run_test!
      end
    end
  end
end
    