class Bill < ApplicationRecord
  include Paginatable

  belongs_to :order
  validates :status_bill, :total, presence: true 
  validates :order_id, uniqueness: true
  before_validation :set_values

  after_create do
    Table.update(order.table_id, avaliable_table: true)
  end

  def set_values
    total_value = 0
    self.total = order.total + total_value
    self.status_bill = true
  end
end
