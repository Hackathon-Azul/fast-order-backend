json.orders do
    json.array! @orders do |order| 
     json.(order, :id, :client_name, :table_id, :user_id, :status, :total)
  end
end
