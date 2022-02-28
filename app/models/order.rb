class Order < ApplicationRecord
  include Paginatable

  belongs_to :table
  belongs_to :user
  has_many :order_items

  enum status: { Waiting: 0, InProgress: 1, Avaliable: 2, Finished: 3, Canceled: 4 }
  validates :client_name, :status, :total, presence: true
  accepts_nested_attributes_for :order_items, allow_destroy: true
  
  around_update :make_bill, if: -> { self.status_changed?(to: 'Finished') }

  before_validation :set_price

  after_create do
    Table.find(self.table_id).update(avaliable_table: false)
  end

    def make_bill
      yield
      Bill.create(order_id: self.id)
    end

    def set_price
      total_value = 0
      order_items.each do |oi|
        total_value += oi.quantity * oi.product.price
    end
      self.total = total_value
  end
end
