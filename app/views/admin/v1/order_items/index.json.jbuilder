json.order_items do
  json.array! @loading_service.records, :id, :product_id, :order_id, :quantity, :comments
end 

  json.meta do
    json.partial! 'shared/pagination', pagination: @loading_service.pagination
  end 