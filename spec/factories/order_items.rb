FactoryBot.define do
  factory :order_item do
    product 
    order 
    quantity { 1 }
    comments { "MyString" }
  end
end
