module Storefront::V1
  class TablesController < ApplicationController

    def index
      @tables = Table.order(:id)
    end
  end
end