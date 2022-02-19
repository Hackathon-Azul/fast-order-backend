class Order < ApplicationRecord
  belongs_to :table
  belongs_to :user
  enum status: { Waiting: 0, InProgress: 1, Avaliable: 2, Finished: 3, Canceled: 4 }
  validates :client_name, presence: true
  validates :status, presence: true
end
