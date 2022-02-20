# frozen_string_literal: true

class Product < ApplicationRecord
  include LikeSearchable
  include Paginatable
  
  belongs_to :category
  validates :name, presence: true
  validates :description, presence: true
  validates :price, presence: true, numericality: { greater_than: 0 }
end
