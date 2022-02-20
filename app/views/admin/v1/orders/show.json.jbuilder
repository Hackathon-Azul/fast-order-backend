  json.order do
    json.(@order, :client_name, :table_id, :user_id, :status, :total)
    json.line_items @order.line_items do |line_item| 
      json.(line_item, :quantity, :payed_price)
      json.image_url rails_blob_url(line_item.product.image)
      json.product line_item.product.name
    end
  end