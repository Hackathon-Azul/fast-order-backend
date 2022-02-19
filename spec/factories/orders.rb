FactoryBot.define do
  factory :order do
    client_name { "MyString" }
    table 
    user 
    status { 1 }
    total { "9.99" }
  end
end
