class Table < ApplicationRecord
    validates :table_number, presence: true
    validates :avaliable_table, presence: true

end
