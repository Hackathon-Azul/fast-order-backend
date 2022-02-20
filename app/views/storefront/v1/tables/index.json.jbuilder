json.tables do
    json.array! @tables, :id, :table_number, :avaliable_table
  end