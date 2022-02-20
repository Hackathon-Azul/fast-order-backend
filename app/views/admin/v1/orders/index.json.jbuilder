json.orders do
    json.array! @loading_service.records do |order| 
     json.(order, :client_name, :table_id, :user_id, :status)
  end
end

json.meta do
    json.partial! 'shared/pagination', pagination: @loading_service.pagination
  end
