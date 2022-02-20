class Order < ApplicationRecord
  belongs_to :table
  belongs_to :user
  has_many :order_items

  enum status: { Waiting: 0, InProgress: 1, Avaliable: 2, Finished: 3, Canceled: 4 }
  validates :client_name, :status, :order, presence: true
  accepts_nested_attributes_for :order_items, allow_destroy: true

  before_validation :set_price

  def set_price
    total = 0
    order_items.each do |oi|
      total += oi.quantity * oi.product.price
  end

end
