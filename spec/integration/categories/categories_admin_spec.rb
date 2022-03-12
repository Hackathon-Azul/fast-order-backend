require 'swagger_helper'

describe 'Categories API' do

 path '/admin/v1/categories' do
  
    get 'Get all Categories' do
      tags 'Categories'
      parameter name: :page, in: :query, type: :integer, description: 'Page number. Default: 1', required: false
      parameter name: :length, in: :query, type: :integer, description: 'Per page items.', required: false
      parameter name: :search, in: :query, type: :string, description: 'Search categories by name.', required: false
      parameter name: :order, in: :query, type: :string, description: 'Categories ordenation.', required: false

      produces 'application/json'

      response '200', 'category found' do
        schema type: :object,
        properties: {
          categories: {
            type: :array,
            items: {
              type: :object,
              properties: {
                id: { type: :integer },
                title: { type: :string }
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

        let(:id) { User.create(:bill).id }
         run_test!
      end
    end

    post 'Create new category' do
        tags 'Categories'
 #       parameter name: 'Authorization', in: :header, type: :string, default: 'Bearer c36e6eadde881ca7'
          parameter name: :category, in: :header, schema: {
            type: :object,
            properties: {
              title: { type: :string },
            },
            required: %w[title]
          }
  
        response '401', :unauthorized do
          let(:Authorization) { '' }
          let(:bill) { { title: '122' } }
          run_test!
        end
  
        response '201', :created do
          let!(:user) { create(:user) }
        #   let(:Authorization) { 'Bearer ' + user.authentication_token }
          let(:category) { { title: 'massas' } }
        run_test!
        end
  
        response '422', :invalid_request do
          let!(:user) { create(:user) }
          let(:Authorization) { 'Bearer ' + user.authentication_token }
          let(:category) { { id: 1 } }
          run_test!
        end
      end
    end

    path '/admin/v1/categories/{id}' do

     get 'Find a category by id' do
       tags 'Categories'
       produces 'application/json'
       parameter name: :id, :in => :path, :type => :string
 
       response '200', 'category found' do
         schema type: :object,
         properties: {
          category: {
            type: :object,
            properties: {
              id: { type: :integer },
              title: { type: :string }
            }
          }
           
        },
           required: [ 'id', 'title' ]
 
         let(:id) { category.create(title: "massas").id }
         run_test!
       end
 
       response '404', 'category not found' do
         let(:id) { 'invalid' }
         run_test!
       end
     end

     put 'Update category by id' do
        tags 'Categories'
        parameter name: :id, :in => :path, :type => :string
        parameter name: :category, in: :header, schema: {
          type: :object,
          properties: {
            title: { type: :string },
        },
        required: ['title']
    }
        response '200', :success do
          let!(:user) { create(:user) }
          let!(:id) { create(:category, user: user).id }
          let(:Authorization) { 'Bearer ' + user.authentication_token }
          let(:category) {{ title: "massas" }} 
          run_test!
        end
  
        response '404', :not_found do
          let!(:user) { create(:user) }
          let(:Authorization) { 'Bearer ' + user.authentication_token }
          let(:category) {{ title: "massas" }} 
          let!(:id) { 'invalid' }
          run_test!
        end
      end

      delete 'Delete category by id' do
        tags 'Categories'
        parameter name: :id, in: :path, type: :integer
        parameter name: 'Authorization', in: :header, type: :string, default: 'Bearer c36e6eadde881ca7'
        response '204', :no_content do
          let!(:user) { create(:user) }
          let(:Authorization) { 'Bearer ' + user.authentication_token }
          let!(:id) { create(:category, user: user).id }
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
    