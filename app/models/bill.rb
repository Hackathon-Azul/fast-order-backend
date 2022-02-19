class Bill < ApplicationRecord
  belongs_to :order
  validates :status_bill, presence: true 
end
