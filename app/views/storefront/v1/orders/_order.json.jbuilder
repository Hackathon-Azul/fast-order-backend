json.id order.id
json.table_id order.table_id
json.total_value order.total
json.status order.status
json.user_id order.user_id
json.client_name order.client_name

json.order_items_attributes order.order_items do |item|
    json.partial! 'storefront/v1/order_items/item', item: item
  end