class Order < ApplicationRecord
  belongs_to :table
  belongs_to :user
  enum status: { Waiting: 0, In Progress: 1, Avaliable: 2, Finished: 3, Canceled: 4 }

end
