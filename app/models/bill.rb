class Bill < ApplicationRecord
  belongs_to :order
  validates :status_bill, :total, presence: true 

  before_validation :set_price

  def set_price
    total = 0
    total = order.quantity * order.product.price
  end
end
