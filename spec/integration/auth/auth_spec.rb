require 'swagger_helper'

describe 'Auth API' do

 path '/auth/v1/users/sign_in' do
  
    post 'User sign in' do
      tags 'Auth'
      produces 'application/json'

      response '200', 'auth found' do
        schema type: :object,
        properties: {
            data: {
            type: :object,
              properties: {
                id: { type: :integer },
                email: { type: :string, format: :email },
                provider: { type: :string },
                name: { type: :string },
                uid: { type: :string, format: :email },
                allow_password_change: { type: :boolean },
                profile: { type: :string },
        
              }
          }
        }

        let(:id) { User.create(name: "Gisele", email: "test@test.com", password: "123456", password_confirmation: "123456").id }
         run_test!
      end
    end


    path '/auth/v1/user' do

    post 'Create new user' do
      tags 'Auth'
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
end

  path '/auth/v1/user/password' do

   post 'Forget password' do
     tags 'Auth'
     produces 'application/json'
     response '200', 'auth found' do
       schema type: :object,
       properties: {
            email: { type: :string, format: :email },
            redirect_url: { type: :string }
         
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

   patch 'Change user password' do
      tags 'Auth'
      parameter name: :auth, in: :header, schema: {
        type: :object,
        properties: {
            reset_password_token: { type: :string },
            password: { type: :string },
            password_confirmation: { type: :string }
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
  end
end