class Table < ApplicationRecord
    include LikeSearchable
    include Paginatable

    has_many :orders

    validates :table_number, presence: true, numericality: { only_integer: true, greater_than: 0 }
    validates :avaliable_table, inclusion: { in: [ true, false ] }
    before_validation :set_default_avaliable, on: :create

    private

    def set_default_avaliable
      self.avaliable_table = true
    end
end
