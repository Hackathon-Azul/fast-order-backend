require 'swagger_helper'

describe 'Bills API' do

 path '/admin/v1/bills' do
  
    get 'Get all Bills' do
      tags 'Bills'
      parameter name: :page, in: :query, type: :integer, description: 'Page number. Default: 1', required: false
      parameter name: :length, in: :query, type: :integer, description: 'Per page items.', required: false
      parameter name: :search, in: :query, type: :string, description: 'Search bills by name.', required: false
      parameter name: :order, in: :query, type: :string, description: 'Bills ordenation.', required: false

      produces 'application/json'

      response '200', 'bills found' do
        schema type: :object,
        properties: {
            bills: {
            type: :array,
            items: {
              type: :object,
              properties: {
                id: { type: :integer },
                order_id: { type: :integer },
                status_bill: { type: :boolean },
                total: { type: :integer },
                created_at: { type: :string }
        
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

    post 'Create new bill' do
        tags 'Bills'
 #       parameter name: 'Authorization', in: :header, type: :string, default: 'Bearer c36e6eadde881ca7'
        parameter name: :bill, in: :header, schema: {
          type: :object,
          properties: {
            status_bill: { type: :boolean },
            order_id: { type: :integer },
            total: { type: :integer }
        },
          required: %w[status_bill order_id total]
        }
  
        response '401', :unauthorized do
          let(:Authorization) { '' }
          let(:bill) { { order_id: 1, status_bill: true, total: 122 } }
          run_test!
        end
  
        response '201', :created do
          let!(:user) { create(:user) }
        #   let(:Authorization) { 'Bearer ' + user.authentication_token }
          let(:bill) { { order_id: 1, status_bill: true, total: 122 } }
        run_test!
        end
  
        response '422', :invalid_request do
          let!(:user) { create(:user) }
          let(:Authorization) { 'Bearer ' + user.authentication_token }
          let(:bill) { { order_id: 1 } }
          run_test!
        end
      end
    end

    path '/admin/v1/bills/{id}' do

     get 'Find a bill by id' do
       tags 'Bills'
       produces 'application/json'
       parameter name: :id, :in => :path, :type => :string
 
       response '200', 'bills found' do
         schema type: :object,
         properties: {
            id: { type: :integer },
            order_id: { type: :integer },
            status_bill: { type: :boolean },
            total: { type: :integer },
            created_at: { type: :string, format: :datetime }
        },
           required: [ 'id', 'status_bill', 'order_id', 'total' ]
 
         let(:id) { Bill.create(order_id: 1, status_bill: true, total: 122).id }
         run_test!
       end
 
       response '404', 'bills not found' do
         let(:id) { 'invalid' }
         run_test!
       end
     end

     put 'Update bill by id' do
        tags 'Bills'
        parameter name: :id, :in => :path, :type => :string
        parameter name: :bill, in: :header, schema: {
          type: :object,
          properties: {
            status_bill: { type: :boolean },
            order_id: { type: :integer },
            total: { type: :integer }
        },
        required: ['id']
    }
        response '200', :success do
          let!(:user) { create(:user) }
          let!(:id) { create(:order, user: user).id }
          let(:Authorization) { 'Bearer ' + user.authentication_token }
          let(:bill) {{ order_id: 1, status_bill: true, total: 122 }} 
          run_test!
        end
  
        response '404', :not_found do
          let!(:user) { create(:user) }
          let(:Authorization) { 'Bearer ' + user.authentication_token }
          let(:bill) {{ order_id: 1 }} 
          let!(:id) { 'invalid' }
          run_test!
        end
      end

      delete 'Delete bill by id' do
        tags 'Bills'
        parameter name: :id, in: :path, type: :integer
        parameter name: 'Authorization', in: :header, type: :string, default: 'Bearer c36e6eadde881ca7'
        response '204', :no_content do
          let!(:user) { create(:user) }
          let(:Authorization) { 'Bearer ' + user.authentication_token }
          let!(:id) { create(:bill, user: user).id }
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
    