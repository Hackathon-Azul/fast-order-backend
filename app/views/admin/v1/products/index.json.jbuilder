json.products do
  json.array! @loading_service.records, :id, :name, :description, :price, :avaiable, :category_id
end 

  json.meta do
    json.partial! 'shared/pagination', pagination: @loading_service.pagination
  end 