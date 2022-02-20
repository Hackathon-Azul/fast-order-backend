json.tables do
  json.array! @loading_service.records, :id, :table_number, :avaliable_table
end 

  json.meta do
    json.partial! 'shared/pagination', pagination: @loading_service.pagination
  end 