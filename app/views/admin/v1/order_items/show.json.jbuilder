json.order_items do
    json.(@order_item,  :id, :product_id, :order_id, :quantity, :comments)
  end 