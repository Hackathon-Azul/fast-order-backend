class Table < ApplicationRecord
    include LikeSearchable
    include Paginatable

    has_many :orders

    validates :table_number, presence: true, numericality: { only_integer: true, greater_than: 0 }
    validates :avaliable_table, presence: true

end
