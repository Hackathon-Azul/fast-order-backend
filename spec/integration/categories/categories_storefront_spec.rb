require 'swagger_helper'

describe 'Categories API' do

 path '/storefront/v1/categories' do
  
    get 'Get all categories' do
      tags 'Categories'
      produces 'application/json'

      response '200', 'name found' do
        schema type: :object,
        properties: {
          categories: {
            type: :array,
            items: {
              type: :object,
              properties: {
                id: { type: :integer },
                title: { type: :string },
        
              }
            }
          }
        }

        let(:id) { Category.create(title: 'Pizza').id }
         run_test!
      end
    end
  end
end