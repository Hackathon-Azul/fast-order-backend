json.id order.id
json.table_id order.table_id
json.total_value order.total
json.status order.status
json.user order.user_id
json.client order.client_name

json.order_items order.order_items do |item|
    json.partial! 'storefront/v1/order_items/item', item: item
  end