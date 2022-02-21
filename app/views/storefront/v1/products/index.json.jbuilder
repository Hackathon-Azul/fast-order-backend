json.products do
    json.array! @loading_service.records do |product|
      json.(product, :id, :name, :description, :avaiable)
      json.price product.price.to_f
      json.category product.category
    end
  end
  
  json.meta do
    json.partial! 'shared/pagination', pagination: @loading_service.pagination
  end