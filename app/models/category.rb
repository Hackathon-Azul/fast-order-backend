# frozen_string_literal: true

class Category < ApplicationRecord
  include LikeSearchable
  include Paginatable
  validates :title, presence: true
  validates :title, uniqueness: { case_sensitive: false }
  has_many :products
end
