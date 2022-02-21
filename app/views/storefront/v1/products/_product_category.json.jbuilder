json.id product.id
json.name product.name
json.description product.description
json.price product.price
json.avaliable product.avaliable
json.categories product.categories do |category|
  json.partial! 'categories/category', category: category
end