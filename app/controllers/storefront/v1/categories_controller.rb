module Storefront::V1
  class CategoriesController < ApiController

    def index
      @categories = Category.order(:title)
    end
  end
end