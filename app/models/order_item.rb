class OrderItem < ApplicationRecord
  belongs_to :product
  belongs_to :order
  has_many :products
  has_many :orders

  validates :quantity, presence: true, numericality: { only_integer: true, greater_than: 0 }
end
