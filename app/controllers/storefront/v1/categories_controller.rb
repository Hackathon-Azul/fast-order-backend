module Storefront::V1
  class CategoriesController < ApplicationController

    def index
      @categories = Category.order(:title)
    end
  end
end