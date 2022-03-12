require 'swagger_helper'

describe 'Users API' do

 path '/admin/v1/users' do
  
    get 'Get all Users' do
      tags 'Users'
      parameter name: :page, in: :query, type: :integer, description: 'Page number. Default: 1', required: false
      parameter name: :length, in: :query, type: :integer, description: 'Per page items.', required: false
      parameter name: :search, in: :query, type: :string, description: 'Search users by name.', required: false
      parameter name: :order, in: :query, type: :string, description: 'Users ordenation.', required: false

      produces 'application/json'

      response '200', 'name found' do
        schema type: :object,
        properties: {
          users: {
            type: :array,
            items: {
              type: :object,
              properties: {
                id: { type: :integer },
                name: { type: :string },
                email: { type: :string, format: :email },
                profile: { type: :string },
        
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

        let(:id) { User.create(name: "Gisele", email: "test@test.com", password: "123456", password_confirmation: "123456").id }
         run_test!
      end
    end

    post 'Create new users' do
      tags 'Users'
#       parameter name: 'Authorization', in: :header, type: :string, default: 'Bearer c36e6eadde881ca7'
      parameter name: :user, in: :header, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          password: { type: :string },
          password_confirmation: { type: :string },
          email: { type: :string, format: :email },
          profile: { type: :string },
        },
        required: %w[name password password_confirmation email]
      }

      response '401', :unauthorized do
        let(:Authorization) { '' }
        let(:user) { { name: "Gisele", email: "test@test.com", password: "123456", password_confirmation: "123456" } }
        run_test!
      end

      response '201', :created do
    
        let(:Authorization) { 'Bearer ' + user.authentication_token }
        let(:user) { { name: "Gisele", email: "test@test.com", password: "123456", password_confirmation: "123456" } }
        run_test!
      end

      response '422', :invalid_request do
        let(:Authorization) { 'Bearer ' + user.authentication_token }
        let(:user) { { id: 1 } }
        run_test!
      end
    end
  end

  path '/admin/v1/users/{id}' do

   get 'Find a user by id' do
     tags 'Users'
     produces 'application/json'
     parameter name: :id, :in => :path, :type => :string

     response '200', 'user found' do
       schema type: :object,
       properties: {
        user: {
          type: :object,
          properties: {
            id: { type: :integer },
            name: { type: :string },
            email: { type: :string, format: :email },
            profile: { type: :string },
          }
        }
         
      },
         required: [ 'id'  ]

       let(:id) { User.create(name: "Gisele", email: "test@test.com", password: "123456", password_confirmation: "123456").id }
       run_test!
     end

     response '404', 'user not found' do
       let(:id) { 'invalid' }
       run_test!
     end
   end

   put 'Update user by id' do
      tags 'Users'
      parameter name: :id, :in => :path, :type => :string
      parameter name: :user, in: :header, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          email: { type: :string, format: :email },
          profile: { type: :string }
      },
      required: %w[name]
    }
      response '200', :success do
        let!(:user) { create(:user) }
        let!(:id) { create(:product, user: user).id }
        let(:Authorization) { 'Bearer ' + user.authentication_token }
        let(:user) {{ name: "Gisele", email: "test@test.com", password: "123456", password_confirmation: "123456" }} 
        run_test!
      end

      response '404', :not_found do
        let!(:user) { create(:user) }
        let(:Authorization) { 'Bearer ' + user.authentication_token }
        let(:user) {{ id: 9 }} 
        let!(:id) { 'invalid' }
        run_test!
      end
    end

      delete 'Delete user by id' do
        tags 'Users'
        parameter name: :id, in: :path, type: :integer
        parameter name: 'Authorization', in: :header, type: :string, default: 'Bearer c36e6eadde881ca7'
        response '204', :no_content do
          let!(:user) { create(:user) }
          let(:Authorization) { 'Bearer ' + user.authentication_token }
          let!(:id) { create(:user, user: user).id }
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