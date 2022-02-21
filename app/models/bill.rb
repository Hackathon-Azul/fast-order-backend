class Bill < ApplicationRecord
  belongs_to :order
  validates :status_bill, :total, presence: true 

  before_validation :set_values

  def set_values
    total_value = 0
    self.total = order.quantity * order.product.price + total_value
    self.status_bill = true
  end
end
