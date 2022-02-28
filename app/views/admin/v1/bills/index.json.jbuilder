json.bills do
  json.array! @loading_service.records, :id, :order_id, :status_bill, :total, :created_at
end 

  json.meta do
    json.partial! 'shared/pagination', pagination: @loading_service.pagination
  end 