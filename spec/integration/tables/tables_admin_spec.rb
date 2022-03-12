require 'swagger_helper'

describe 'Tables API' do

 path '/admin/v1/tables' do
  
    get 'Get all Tables' do
      tags 'Tables'
      parameter name: :page, in: :query, type: :integer, description: 'Page number. Default: 1', required: false
      parameter name: :length, in: :query, type: :integer, description: 'Per page items.', required: false
      parameter name: :search, in: :query, type: :string, description: 'Search tables by name.', required: false
      parameter name: :order, in: :query, type: :string, description: 'Tables ordenation.', required: false

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
                table_number: { type: :integer },
                avaliable_table: { type: :boolean }
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

        let(:id) { User.create(:table).id }
         run_test!
      end
    end

    post 'Create new tables' do
        tags 'Tables'
 #       parameter name: 'Authorization', in: :header, type: :string, default: 'Bearer c36e6eadde881ca7'
        parameter name: :table, in: :header, schema: {
          type: :object,
          properties: {
            table_number: { type: :integer },
            avaliable_table: { type: :boolean }
          },
          required: %w[table_number avaliable_table]
        }
  
        response '401', :unauthorized do
          let(:Authorization) { '' }
          let(:table) { { name: '122' } }
          run_test!
        end
  
        response '201', :created do
          let!(:user) { create(:user) }
        #   let(:Authorization) { 'Bearer ' + user.authentication_token }
          let(:table) { { table_number: 9, avaliable_table: true } }
          run_test!
        end
  
        response '422', :invalid_request do
          let!(:user) { create(:user) }
          let(:Authorization) { 'Bearer ' + user.authentication_token }
          let(:table) { { id: 1 } }
          run_test!
        end
      end
    end

    path '/admin/v1/tables/{id}' do

     get 'Find a table by id' do
       tags 'Tables'
       produces 'application/json'
       parameter name: :id, :in => :path, :type => :string
 
       response '200', 'table found' do
         schema type: :object,
         properties: {
          product: {
            type: :object,
            properties: {
              table_number: { type: :integer },
              avaliable_table: { type: :boolean }
            }
          }
           
        },
           required: [ 'table_number', 'avaliable_table' ]
 
         let(:id) { Table.create(table_number: 9, avaliable_table: true).id }
         run_test!
       end
 
       response '404', 'table not found' do
         let(:id) { 'invalid' }
         run_test!
       end
     end

     put 'Update table by id' do
        tags 'Tables'
        parameter name: :id, :in => :path, :type => :string
        parameter name: :table, in: :header, schema: {
          type: :object,
          properties: {
            table_number: { type: :integer },
            avaliable_table: { type: :boolean }
        },
        required: %w[table_number avaliable_table]
      }
        response '200', :success do
          let!(:user) { create(:user) }
          let!(:id) { create(:product, user: user).id }
          let(:Authorization) { 'Bearer ' + user.authentication_token }
          let(:product) {{ table_number: 9, avaliable_table: true }} 
          run_test!
        end
  
        response '404', :not_found do
          let!(:user) { create(:user) }
          let(:Authorization) { 'Bearer ' + user.authentication_token }
          let(:product) {{ table_number: 9, avaliable_table: true }} 
          let!(:id) { 'invalid' }
          run_test!
        end
      end

      delete 'Delete table by id' do
        tags 'Tables'
        parameter name: :id, in: :path, type: :integer
        parameter name: 'Authorization', in: :header, type: :string, default: 'Bearer c36e6eadde881ca7'
        response '204', :no_content do
          let!(:user) { create(:user) }
          let(:Authorization) { 'Bearer ' + user.authentication_token }
          let!(:id) { create(:table, user: user).id }
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
    