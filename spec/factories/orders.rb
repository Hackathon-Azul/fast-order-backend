FactoryBot.define do
  factory :order do
    client_name { "MyString" }
    table { nil }
    user { nil }
    status { 1 }
    total { "9.99" }
  end
end
